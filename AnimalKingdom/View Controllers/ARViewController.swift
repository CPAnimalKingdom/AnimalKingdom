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
    var animations = [String: CAAnimation]()
    var planes = [UUID: ARPlane]()
    var idle: Bool = true
    var modelNode: SCNNode?
    let walkKey = "walk"


    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        sceneView.delegate = self
        sceneView.showsStatistics = true
//        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]

        // TODO: Lighting
        sceneView.autoenablesDefaultLighting = false

        let scene = SCNScene()
        sceneView.scene = scene

        UIApplication.shared.isIdleTimerDisabled = true
        loadAnimations()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        sceneView.session.pause()
        UIApplication.shared.isIdleTimerDisabled = false
    }

    // MARK: Helpers

    func insertModel(position: SCNVector3 = SCNVector3(0, -1, -2), scale: SCNVector3 = SCNVector3(0.05, 0.05, 0.05)) {
        let idleScene = SCNScene(named: "art.scnassets/Elephant.dae")!

        let node = SCNNode()
        for child in idleScene.rootNode.childNodes {
            node.addChildNode(child)
        }

        node.position = position
        node.scale = scale

        sceneView.scene.rootNode.addChildNode(node)
        modelNode = node
    }

    func loadAnimations() {
        //Walk
        let startWalk = 25.5666667064031
        let endWalk = 27.5666667064031
        loadAnimation(key: walkKey, startTime: startWalk, endTime: endWalk)
    }

    func loadAnimation(key: String, startTime: Double, endTime: Double) {
        let sceneName = "art.scnassets/Elephant9Animations"
        let animationIdentifier = "Elephant9Animations-1"

        let sceneURL = Bundle.main.url(forResource: sceneName, withExtension: "dae")
        let sceneSource = SCNSceneSource(url: sceneURL!, options: nil)

        if let animationsObject = sceneSource?.entryWithIdentifier(animationIdentifier, withClass: CAAnimation.self) {
            let animation = CAAnimationGroup()
            let sub = animationsObject.copy() as! CAAnimation
            sub.timeOffset = 25.5666667064031
            animation.animations = [sub]
            animation.duration = 27.5666667064031 - sub.timeOffset
            animation.repeatCount = Float.greatestFiniteMagnitude

            animations[key] = animation
        }
    }

    func playAnimation(key: String) {
        sceneView.scene.rootNode.addAnimation(animations[key]!, forKey: key)
    }

    func stopAnimation(key: String) {
        sceneView.scene.rootNode.removeAnimation(forKey: key, blendOutDuration: CGFloat(0.5))
    }

    // MARK: Animation

    var isWalking = false

    func toggleWalk() {
        guard let modelNode = modelNode else { return }

        if !isWalking {
            playAnimation(key: walkKey)

            let walkAction = SCNAction.move(to: SCNVector3Make(modelNode.position.x, modelNode.position.y, modelNode.position.z + 1), duration: 2.0)
            modelNode.runAction(walkAction, forKey: walkKey)

            isWalking = true
        } else {
            stopAnimation(key: walkKey)

            modelNode.removeAction(forKey: walkKey)

            isWalking = false
        }
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

                insertModel(position: position)
            }
        } else {
            // Test if 3D Object was touch
            var hitTestOptions = [SCNHitTestOption: Any]()
            hitTestOptions[SCNHitTestOption.boundingBoxOnly] = true

            let hitResults: [SCNHitTestResult]  = sceneView.hitTest(location, options: hitTestOptions)

            if hitResults.first != nil {
                if(idle) {
                    playAnimation(key: "Walk")
                } else {
                    stopAnimation(key: "Walk")
                }
                idle = !idle
                return
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

    @IBAction func onPan(_ pan: UIPanGestureRecognizer) {
        guard let modelNode = modelNode else { return }

        let location = pan.location(in: sceneView)

        let planeHitTestResults = sceneView.hitTest(location, types: .existingPlaneUsingExtent)
        if let result = planeHitTestResults.first {
            let planeHitTestPosition = result.worldTransform.translation

            modelNode.simdPosition = planeHitTestPosition
        }
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
