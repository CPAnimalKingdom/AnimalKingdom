//
//  ARViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ARViewController: UIViewController {

    @IBOutlet var sceneView: VirtualObjectARView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    var focusSquare = FocusSquare()
    /// A serial queue used to coordinate adding or removing nodes from the scene.
    let updateQueue = DispatchQueue(label: "com.example.naderneyzi.AnimalKingdom.serialSceneKitQueue")
    var screenCenter: CGPoint {
        let bounds = sceneView.bounds
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    var animations = [String: CAAnimation]()
    var planes = [UUID: ARPlane]()
    var idle: Bool = true
    var modelNode: SCNNode?
    var isIdle = false
    let walkKey = "walk"
    let breatheKey = "breathe"
    let lookAroundKey = "lookAround"
    let lookaroundEatKey = "lookAroundEat"
    let chewKey = "chew"
    let comboAttackKey = "comboAttackKey"
    let cameraFlashView = UIView()

    var modelNotPlaced = true

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // SCNScene
        sceneView.scene = SCNScene()
        sceneView.delegate = self

        // Set up scene content.
        setupCamera()
        sceneView.scene.rootNode.addChildNode(focusSquare)

        // Load Model
        let idleScene = SCNScene(named: "art.scnassets/Elephant.dae")!
        modelNode = SCNNode()
        for child in idleScene.rootNode.childNodes {
            modelNode!.addChildNode(child)
        }

        // Lighting
        // `.automaticallyUpdatesLighting` option creates an ambient light source and modulates its intensity.
        sceneView.automaticallyUpdatesLighting = false
        // This modulates a global lighting environment map for use with physically based materials, so disable automatic lighting.
        if let environmentMap = UIImage(named: "art.scnassets/environment_blur.exr") {
            sceneView.scene.lightingEnvironment.contents = environmentMap
        }

        // Camera Button
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height / 2
        cameraButton.layer.borderWidth = 3
        cameraButton.layer.borderColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 12, right: 10)
        cameraButton.imageView?.contentMode = .scaleAspectFill
        cameraButton.clipsToBounds = true
        cameraButton.alpha = 0.7

        // Camera Flash
        cameraFlashView.backgroundColor = UIColor.black
        cameraFlashView.alpha = 0
        sceneView.addSubview(cameraFlashView)

        UIApplication.shared.isIdleTimerDisabled = true
        loadAnimations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        cameraFlashView.frame = sceneView.frame

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
//        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
        UIApplication.shared.isIdleTimerDisabled = false
    }

    // MARK: StatusBar

    override var prefersStatusBarHidden : Bool {
        return true
    }

    // MARK: - Focus Square

    func updateFocusSquare() {
        // We should always have a valid world position unless the sceen is just being initialized.
        guard let (worldPosition, planeAnchor, _) = sceneView.worldPosition(fromScreenPosition: screenCenter, objectPosition: focusSquare.lastPosition) else {
            updateQueue.async {
                self.focusSquare.state = .initializing
                self.sceneView.pointOfView?.addChildNode(self.focusSquare)
            }
            return
        }

        updateQueue.async {
            self.sceneView.scene.rootNode.addChildNode(self.focusSquare)
            let camera = self.sceneView.session.currentFrame?.camera

            if let planeAnchor = planeAnchor {
                self.focusSquare.state = .planeDetected(anchorPosition: worldPosition, planeAnchor: planeAnchor, camera: camera)
            } else {
                self.focusSquare.state = .featuresDetected(anchorPosition: worldPosition, camera: camera)
            }
        }
    }

    // MARK: Helpers

    func setupCamera() {
        guard let camera = sceneView.pointOfView?.camera else {
            fatalError("Expected a valid `pointOfView` from the scene.")
        }

        /*
         Enable HDR camera settings for the most realistic appearance
         with environmental lighting and physically based materials.
         */
        camera.wantsHDR = true
        camera.exposureOffset = -1
        camera.minimumExposure = -1
        camera.maximumExposure = 3
    }

    func insertModel(position: SCNVector3 = SCNVector3(0, -1, -2), scale: SCNVector3 = SCNVector3(0.25, 0.25, 0.25)) {
        modelNode!.scale = scale
        modelNode!.position = position

        //Rotate towards camera
        let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
        let combinedTransform = simd_mul(simd_float4x4(modelNode!.worldTransform), rotate)
        modelNode!.simdTransform = combinedTransform

        sceneView.scene.rootNode.addChildNode(modelNode!)

        startIdle()
        modelNotPlaced = false
        focusSquare.isHidden = true
    }

    func loadAnimations() {
        let animationsIdentifier = "Elephant9Animations-1"
        guard let animationsSceneURL = Bundle.main.url(forResource: "art.scnassets/Elephant9Animations", withExtension: "dae") else { return }
        guard let animationsSceneSource = SCNSceneSource(url: animationsSceneURL, options: nil) else { return }

        // Walk
        let startWalk = 25.5666667064031
        let endWalk = 27.5666667064031
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: walkKey, startTime: startWalk, endTime: endWalk, repeatCount: Float.greatestFiniteMagnitude)

        // Idle chew
        let startChew = 0.0
        let endChew = 2.0
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: chewKey, startTime: startChew, endTime: endChew, repeatCount: Float.greatestFiniteMagnitude)

        // Idle lookaround
        let startLookAround = 16.166666666666668
        let endLookAround = 24.166666666666668
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: lookAroundKey, startTime: startLookAround, endTime: endLookAround, repeatCount: Float.greatestFiniteMagnitude)

        // Idle lookaround eat
        let startLookAroundEat = 6.1
        let endLookAroundEat = 15.1
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: lookaroundEatKey, startTime: startLookAroundEat, endTime: endLookAroundEat, repeatCount: Float.greatestFiniteMagnitude)

        // Idle breathe
        let startBreathe = 2.0333333333333332
        let endBreathe = 4.0333333333333332
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: breatheKey, startTime: startBreathe, endTime: endBreathe, repeatCount: Float.greatestFiniteMagnitude)

        // Tusks Combo Attack
        let startComboAttack = 4.0666666666666664
        let endComboAttack = 6.0666666666666664
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: comboAttackKey, startTime: startComboAttack, endTime: endComboAttack, repeatCount: 1)
    }

    func loadAnimation(sceneSource: SCNSceneSource, identifier: String, key: String, startTime: Double, endTime: Double, repeatCount: Float) {
        if let animationsObject = sceneSource.entryWithIdentifier(identifier, withClass: CAAnimation.self) {
            let animation = CAAnimationGroup()
            let sub = animationsObject.copy() as! CAAnimation
            sub.timeOffset = startTime
            animation.animations = [sub]
            animation.duration = endTime - sub.timeOffset
            animation.repeatCount = repeatCount
            animation.fadeInDuration = 0.5

            animations[key] = animation
        }
    }

    func playAnimation(key: String) {
        guard let modelNode = modelNode else { return }

        modelNode.addAnimation(animations[key]!, forKey: key)
    }

    func stopAnimation(key: String) {
        guard let modelNode = modelNode else { return }

        modelNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }

    // MARK: Animation and Action

    func startIdle() {
        playAnimation(key: lookAroundKey)

        isIdle = true
    }

    func stopIdle() {
        stopAnimation(key: lookAroundKey)

        isIdle = false
    }

    func startWalk(destination: SCNVector3) {
        guard let modelNode = modelNode else { return }

        stopIdle()

        playAnimation(key: walkKey)

        let waitAction = SCNAction.wait(duration: 0.3)
        let walkAction = SCNAction.move(to: destination, duration: 2.0)
        let walkSequence = SCNAction.sequence([waitAction, walkAction])
        modelNode.runAction(walkSequence, forKey: walkKey)

//        var reverse = SCNVector3()
//        reverse.x = -destination.x
//        reverse.y = destination.y
//        reverse.z = -destination.z
//        modelNode.look(at: destination)
    }

    func stopWalk() {
        guard let modelNode = modelNode else { return }

        stopAnimation(key: walkKey)
        modelNode.removeAction(forKey: walkKey)

        startIdle()
    }

    func doComboAttack() {
        stopIdle()

        playAnimation(key: comboAttackKey)

        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) + .milliseconds(500), execute: {
            self.stopAnimation(key: self.comboAttackKey)

            self.startIdle()
        })
    }

    func stopActionsAndAnimations() {
        guard let modelNode = modelNode else { return }

        modelNode.removeAllActions()
        modelNode.removeAllAnimations()
    }

    // MARK: Interaction

    @IBAction func onTap(_ tap: UITapGestureRecognizer) {
        guard tap.state == .ended else { return }

        let location = tap.location(in: sceneView)



        if modelNotPlaced {
            let hitPlanes = sceneView.hitTest(location, types: .existingPlane)

            if let firstPlane = hitPlanes.first {
                let planeWorldTransform = firstPlane.worldTransform.columns.3
                let position = SCNVector3Make(planeWorldTransform.x, planeWorldTransform.y, planeWorldTransform.z)

                if let arAnchor = firstPlane.anchor, let arPlane = planes[arAnchor.identifier] {
                    arPlane.opacity = 0.1
                }

                insertModel(position: position)
            }
        } else {
            // Test if 3D Object was touch
            var hitTestOptions = [SCNHitTestOption: Any]()
            hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true

            let hitResults = sceneView.hitTest(location, options: hitTestOptions)
            if let firstHit = hitResults.first {
                // Test if 3D Object is elephant, might be plane
                var didTouchElephant = false
                modelNode?.enumerateChildNodes({ (childNode: SCNNode, stop) in

                    if childNode == firstHit.node {

                        didTouchElephant = true

                        stop.pointee = true
                    }
                })

                if didTouchElephant {
                    // TODO: Do another animation
                    if isIdle {
                        doComboAttack()
                    }
                } else {
                    if isIdle {
                        //Get touched position location based on the plane the user touched
                        let hitPlanes = sceneView.hitTest(location, types: .existingPlane)

                        if let firstPlane = hitPlanes.first {
                            let planeWorldTransform = firstPlane.worldTransform.columns.3
                            let tapPosition = SCNVector3Make(planeWorldTransform.x, planeWorldTransform.y, planeWorldTransform.z)

                            startWalk(destination: tapPosition)

                            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1) + .milliseconds(500), execute: {
                                self.stopWalk()
                            })
                        }
                    } else {
                        stopWalk()
                        startIdle()
                    }
                }
            }
        }
    }

    @IBAction func onPinch(_ pinch: UIPinchGestureRecognizer) {
        guard let modelNode = modelNode else { return }

        if pinch.state == .changed {
            let pinchScaleX = Float(pinch.scale) * modelNode.scale.x
            let pinchScaleY = Float(pinch.scale) * modelNode.scale.y
            let pinchScaleZ = Float(pinch.scale) * modelNode.scale.z
            modelNode.scale = SCNVector3Make(pinchScaleX, pinchScaleY, pinchScaleZ)

            pinch.scale = 1
        }
    }

    @IBAction func onRotation(_ rotation: UIRotationGestureRecognizer) {
        guard let modelNode = modelNode else { return }

        if rotation.state == .changed {
            modelNode.eulerAngles.y -= Float(rotation.rotation)

            rotation.rotation = 0
        }
    }

    var isPan = true

    @IBAction func onPan(_ pan: UIPanGestureRecognizer) {
        guard let modelNode = modelNode else { return }

        let location = pan.location(in: sceneView)

        let planeHitTestResults = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        if let result = planeHitTestResults.first {
            let planeHitTestPosition = result.worldTransform.translation

            modelNode.simdPosition = planeHitTestPosition
        }

    }

    // MARK: - Take Picture
    
    @IBAction func onCameraTap(_ sender: Any) {
        let image = sceneView.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

        AudioServicesPlayAlertSound(1108) // Camera alert sound and vibration
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .autoreverse, animations: {
            self.cameraButton.alpha = 0
            self.cameraFlashView.alpha = 1
        }) { (done) in
            self.cameraButton.alpha = 1
            self.cameraFlashView.alpha = 0
        }
    }

    // MARK: - ARSessionObserver

    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay.
        //        sessionInfoLabel.text = "Session was interrupted"
    }

    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required.
        //        sessionInfoLabel.text = "Session interruption ended"
        //        resetTracking()
    }

    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user.
        //        sessionInfoLabel.text = "Session failed: \(error.localizedDescription)"
        //        resetTracking()
    }
}
