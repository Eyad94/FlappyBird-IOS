//
//  ScoreViewController.swift
//  FlappyBird
//
//  Created by Ali on 19/07/2019.
//  Copyright © 2019 Afeka. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource {
    
    var data:[Score]?

    @IBOutlet weak var TableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.TableView.tableFooterView = UIView()
        TableView.delegate = self
        TableView.dataSource = self
        
        
        
        data = Score.loadFromDisk()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoresTableViewCell") as! ScoresTableViewCell
        
        if(data != nil)
        {
            cell.nameLabel.text = data?[indexPath.row].name
            cell.levelLabel.text = String(describing: data![indexPath.row].level)
            cell.scoreLabel.text = String(describing: data![indexPath.row].score)
            cell.indexLabel.text = "\(indexPath.row + 1)"
        }
        
        return cell
    }

 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
