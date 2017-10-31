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

class ARViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    var animations = [String: CAAnimation]()
    var planes = [UUID: ARPlane]()
    var idle: Bool = true
    var modelNode: SCNNode?
    var isWalking = false
    let walkKey = "walk"
    let breatheKey = "breathe"
    let lookAroundKey = "lookAround"
    let lookaroundEatKey = "lookAroundEat"
    let chewKey = "chew"
    let cameraFlashView = UIView()

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.backIndicatorImage = myBackButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = myBackButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        // SCNScene
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.delegate = self
//        sceneView.showsStatistics = true

        // TODO: Lighting
        sceneView.autoenablesDefaultLighting = false

        // Camera Button
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height / 2
        cameraButton.layer.borderWidth = 3
        cameraButton.layer.borderColor = UIColor(red: 50.0/255.0, green: 50.0/255.0, blue: 50.0/255.0, alpha: 1).cgColor
        cameraButton.imageEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 12, right: 10)
        cameraButton.imageView?.contentMode = .scaleAspectFill
        cameraButton.clipsToBounds = true
        cameraButton.alpha = 0.7

        // Dismiss Button
        dismissButton.layer.cornerRadius = dismissButton.frame.size.height / 2
        dismissButton.layer.borderWidth = 1.5
        dismissButton.layer.borderColor = dismissButton.titleLabel?.textColor.cgColor
        dismissButton.alpha = 0.7

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

    // MARK: Helpers

    func insertModel(position: SCNVector3 = SCNVector3(0, -1, -2), scale: SCNVector3 = SCNVector3(0.5, 0.5, 0.5)) {
        let idleScene = SCNScene(named: "art.scnassets/Elephant.dae")!

        modelNode = SCNNode()
        for child in idleScene.rootNode.childNodes {
            modelNode!.addChildNode(child)
        }

        modelNode!.scale = scale
        modelNode!.position = position

        //Rotate towards camera
        let rotate = simd_float4x4(SCNMatrix4MakeRotation(sceneView.session.currentFrame!.camera.eulerAngles.y, 0, 1, 0))
        let combinedTransform = simd_mul(simd_float4x4(modelNode!.worldTransform), rotate)
        modelNode!.simdTransform = combinedTransform

        sceneView.scene.rootNode.addChildNode(modelNode!)

        startIdle()
    }

    func loadAnimations() {
        let animationsIdentifier = "Elephant9Animations-1"
        guard let animationsSceneURL = Bundle.main.url(forResource: "art.scnassets/Elephant9Animations", withExtension: "dae") else { return }
        guard let animationsSceneSource = SCNSceneSource(url: animationsSceneURL, options: nil) else { return }

        // Walk
        let startWalk = 25.5666667064031
        let endWalk = 27.5666667064031
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: walkKey, startTime: startWalk, endTime: endWalk)

        // Idle chew
        let startChew = 0.0
        let endChew = 2.0
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: chewKey, startTime: startChew, endTime: endChew)

        // Idle lookaround
        let startLookAround = 16.166666666666668
        let endLookAround = 24.166666666666668
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: lookAroundKey, startTime: startLookAround, endTime: endLookAround)

        // Idle lookaround eat
        let startLookAroundEat = 6.1
        let endLookAroundEat = 15.1
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: lookaroundEatKey, startTime: startLookAroundEat, endTime: endLookAroundEat)

        // Idle breathe
        let startBreathe = 2.0333333333333332
        let endBreathe = 4.0333333333333332
        loadAnimation(sceneSource: animationsSceneSource, identifier: animationsIdentifier, key: breatheKey, startTime: startBreathe, endTime: endBreathe)
    }

    func loadAnimation(sceneSource: SCNSceneSource, identifier: String, key: String, startTime: Double, endTime: Double) {
        if let animationsObject = sceneSource.entryWithIdentifier(identifier, withClass: CAAnimation.self) {
            let animation = CAAnimationGroup()
            let sub = animationsObject.copy() as! CAAnimation
            sub.timeOffset = startTime
            animation.animations = [sub]
            animation.duration = endTime - sub.timeOffset
            animation.repeatCount = Float.greatestFiniteMagnitude
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
    }

    func stopIdle() {
        stopAnimation(key: lookAroundKey)
    }

    func startWalk(destination: SCNVector3) {
        guard let modelNode = modelNode else { return }

        stopIdle()

        playAnimation(key: walkKey)

//        let node = SCNNode()
//        node.tra
//        SCNLookAtConstraint(
//        modelNode.constraints = [SCNLookAtConstraint()]

        let waitAction = SCNAction.wait(duration: 0.5)
        let walkAction = SCNAction.move(to: destination, duration: 2.0)
        let walkSequence = SCNAction.sequence([waitAction, walkAction])
        modelNode.runAction(walkSequence, forKey: walkKey)

        isWalking = true
    }

    func stopWalk() {
        guard let modelNode = modelNode else { return }

        stopAnimation(key: walkKey)
        modelNode.removeAction(forKey: walkKey)

        startIdle()

        isWalking = false
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

        if modelNode == nil {
            let hitPlanes = sceneView.hitTest(location, types: .existingPlane)

            if let firstPlane = hitPlanes.first {
                let planeWorldTransform = firstPlane.worldTransform.columns.3
                let position = SCNVector3Make(planeWorldTransform.x, planeWorldTransform.y, planeWorldTransform.z)

//                if let arAnchor = firstPlane.anchor, let arPlane = planes[arAnchor.identifier] {
//                    arPlane.isHidden = true
//                }

                insertModel(position: position)
            }
        } else {
            // Test if 3D Object was touch
            var hitTestOptions = [SCNHitTestOption: Any]()
            hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true

            let hitResults = sceneView.hitTest(location, options: hitTestOptions)
            if let firstHit = hitResults.first {
                // Test if 3D Object is elephant
                var didTouchElephant = false
                modelNode?.enumerateChildNodes({ (childNode: SCNNode, stop) in

                    if childNode == firstHit.node {

                        didTouchElephant = true

                        stop.pointee = true
                    }
                })

                if didTouchElephant {
                    // TODO: Do another animation
                    if isWalking {
                        stopWalk()
                    }
                } else {
                    //Get touched position location based on the plane the user touched
                    let hitPlanes = sceneView.hitTest(location, types: .existingPlane)

                    if let firstPlane = hitPlanes.first {
                        let planeWorldTransform = firstPlane.worldTransform.columns.3
                        let tapPosition = SCNVector3Make(planeWorldTransform.x, planeWorldTransform.y, planeWorldTransform.z)

                        startWalk(destination: tapPosition)
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

    // MARK: - Dismiss ViewController

    @IBAction func onDismissTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - ARSCNViewDelegate

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else { return }

        let plane = ARPlane.init(planeAnchor)
        planes[planeAnchor.identifier] = plane
        node.addChildNode(plane)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let plane = planes[anchor.identifier] else { return }

        plane.update(planeAnchor: anchor as! ARPlaneAnchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        // TODO: not working right now
        planes.removeValue(forKey: anchor.identifier)
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
