//
//  StartViewController.swift
//  FlappyBird
//
//  Created by Ali on 10/07/2019.
//  Copyright © 2019 Afeka. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    
    var userName = ""

    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
     Main.storyboard
    }
    */
    @IBAction func ScoresButton(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(withIdentifier: "ScoreViewController")as? ScoreViewController{
            
            self.present(vc, animated: true, completion: nil)
        }

    }
    
    
    @IBAction func PlayButton(_ sender: UIButton) {
        
            
        userName = userNameTextField.text!
        
        if(userName.isEmpty){
            
            // display alert message ,ust change***
            print("user name is empty?")
            
            let alert = UIAlertController(title: "alert", message: "name is empty", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler: nil))
            
            self.present(alert , animated: true , completion: nil)
            
            
        }else{
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            if let vc = storyboard.instantiateViewController(withIdentifier: "GameViewController")as? GameViewController{
                
                vc.userName = userName
                
                self.present(vc, animated: true, completion: nil)
            }
        }

    }
    
    
}
