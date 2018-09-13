//
//  TableViewController.swift
//  study notes
//
//  Created by Sergius on 06.09.2018.
//  Copyright © 2018 Sergius. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController: UITableViewController {
    let db = DBService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return db.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskTableViewCell
        
        cell.descriptionLabel?.text = db.tasks[indexPath.row].desc
        cell.subjectLabel?.text = db.tasks[indexPath.row].subject
        cell.expireeLabel?.text = humanReadable(time: expireeTime(fromDate: db.tasks[indexPath.row].deadLine))
        
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            db.eraseTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    func expireeTime(fromDate: Date?) -> (Int, String, Bool) {
        let seconds = Int(floor((fromDate?.timeIntervalSinceNow) ?? 0))
        let expired = seconds < 0
        
        guard abs(seconds) >= 60 else {
            return (seconds, "second", expired)
        }
        let minutes = abs(seconds) / 60
        
        guard minutes >= 60 else {
            return (minutes, "minute", expired)
        }
        let hours = minutes / 60
        
        guard hours >= 24 else {
            return (hours, "hour", expired)
        }
        let days = hours / 24
        
        guard days >= 30 else {
            return (days, "day", expired)
        }
        let months = days / 30
        
        guard months >= 12 else {
            return (months, "month", expired)
        }
        
        return (months / 12, "year", expired)
    }
    
    func humanReadable(time: (count: Int, unit: String, expired: Bool)) -> String {
        return (time.expired ? "Overdue for: " : "To do in: ") + String(time.count) + " " + time.unit + (abs(time.count) > 1 ? "s" : "")
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
