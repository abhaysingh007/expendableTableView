//
//  ViewController.swift
//  Expandble Table View
//
//  Created by abhay singh on 10/02/17.
//  Copyright © 2017 abhay singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var teamIndex = [Int]()
    var details = [Detail]()
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        details = [
            Detail(team: "Avengers", name: ["Abhay", "Abhisek", "Ansiqa", "Ana", "Mia"], isCollapsed: false),
            Detail(team: "Justice League", name: ["Abhay", "Abhisek", "Ansiqa", "Ana", "Mia"]),
            Detail(team: "Ninja Turtles", name: ["Abhay", "Abhisek", "Ansiqa", "Ana", "Mia"]),
        ]
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = details.count
        for detail in details {
            count += detail.name.count
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let section = getSectionIndex((indexPath as NSIndexPath).row)
        let row = getRowIndex((indexPath as NSIndexPath).row)
        // Header has fixed height
        if row == 0 {
            return 50.0
        }
        return details[section].isCollapsed! ? 0 : 44.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Calculate the real section index and row index
        let section = getSectionIndex((indexPath as NSIndexPath).row)
        let row = getRowIndex((indexPath as NSIndexPath).row)
        
        if row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Team") as! DetailTableViewCell
            cell.teamLabel.text = details[section].team
            cell.toggleButton.tag = section
            cell.toggleButton.setTitle(details[section].isCollapsed! ? "+" : "-", for: UIControlState())
            cell.toggleButton.addTarget(self, action: #selector(ViewController.toggleCollapse), for: .touchUpInside)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Members") as UITableViewCell!
            cell?.textLabel?.text = details[section].name[row - 1]
            cell?.textLabel?.textColor = UIColor.lightGray
            return cell!
        }
    }

    
    //
    // MARK: - Event Handlers
    //
    func toggleCollapse(_ sender: UIButton) {
        let section = sender.tag
        let collapsed = details[section].isCollapsed
        
        // Toggle collapse
        details[section].isCollapsed = !collapsed!
        let indices = getHeaderIndices()
        let start = indices[section]
        let end = start + details[section].name.count
        detailTableView.beginUpdates()
        for i in start ..< end + 1 {
            detailTableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
        }
        detailTableView.endUpdates()
    }
    
    //
    // MARK: - Helper Functions
    //
    func getSectionIndex(_ row: NSInteger) -> Int {
        let indices = getHeaderIndices()
        
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                return i
            }
        }
        return -1
    }
    
    func getRowIndex(_ row: NSInteger) -> Int {
        var index = row
        var indices = [Int]()
        if self.teamIndex.isEmpty{
            indices = getHeaderIndices()
        }else{
            indices = teamIndex
        }
        for i in 0..<indices.count {
            if i == indices.count - 1 || row < indices[i + 1] {
                index -= indices[i]
                break
            }
        }
        return index
    }
    
    func getHeaderIndices() -> [Int] {
        var index = 0
        var indices = [Int]()
        
        for detail in details {
            indices.append(index)
            index += detail.name.count + 1
        }
        teamIndex = indices
        return indices
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
