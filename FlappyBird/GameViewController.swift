//
//  GameViewController.swift
//  FlappyBird
//
//  Created by Eyad on 7/7/19.
//  Copyright © 2019 Afeka. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        scene.gameVC = self
        scene.userData = NSMutableDictionary()
        scene.userData?.setValue(userName, forKey: "username")
        let viewSk = view as! SKView
        viewSk.showsFPS = false
        viewSk.showsNodeCount = false
        viewSk.ignoresSiblingOrder = false
        scene.scaleMode = .resizeFill
        viewSk.presentScene(scene)
        
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
