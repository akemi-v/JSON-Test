//
//  CardsViewController.swift
//  JSON Test
//
//  Created by Maria Semakova on 10/19/17.
//  Copyright © 2017 Maria Semakova. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let cardIdentifiers = ["IP Address Cell", "Date & Time Cell", "Echo JSON Cell", "Validation Cell", "Headers Cell"]
    
    let cellData = ["IP Address Cell": "", "Date & Time Cell": "", "Echo JSON Cell": ["request": "", "result": ""], "Validation Cell": ["request": "", "result": ""], "Headers Cell": ""] as [String : Any]
    
//    var cellArray = [] as NSMutableArray
//    var cellArray = [IPAddressCardCell(style: .default, reuseIdentifier: "IP Address Cell"), DateTimeCardCell(style: .default, reuseIdentifier: "Date & Time Cell"), EchoJSONCardCell(style: .default, reuseIdentifier: "Echo JSON Cell"), ValidationCardCell(style: .default, reuseIdentifier: "Validation Cell"), HeadersCardCell(style: .default, reuseIdentifier: "Headers Cell)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.estimatedRowHeight = 44
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .none
        
        
//        cellArray = [IPAddressCardCell().configure(), DateTimeCardCell().configure(), EchoJSONCardCell().configure(), ValidationCardCell().configure(), HeadersCardCell().configure()]

    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCellHeight), name: NSNotification.Name(rawValue: "notificationUpdateCellHeight"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "notificationUpdateCellHeight"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardIdentifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = cardIdentifiers[indexPath.row]
        var cell : UITableViewCell

        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }

        switch identifier {
        case "IP Address Cell":
            if let configuredCell = cell as? IPAddressCardCell {
                configuredCell.configure()
                return configuredCell
            }
        case "Date & Time Cell":
            if let configuredCell = cell as? DateTimeCardCell {
                configuredCell.configure()
                return configuredCell
            }
        case "Echo JSON Cell":
            if let configuredCell = cell as? EchoJSONCardCell {
                configuredCell.requestTextView.layer.borderWidth = 1.0
                configuredCell.requestTextView.layer.borderColor = UIColor(displayP3Red: 48/255, green: 151/255, blue: 186/255, alpha: 1.0).cgColor
                return configuredCell
            }
        case "Validation Cell":
            if let configuredCell = cell as? ValidationCardCell {
                configuredCell.requestTextView.layer.borderWidth = 1.0
                configuredCell.requestTextView.layer.borderColor = UIColor(displayP3Red: 48/255, green: 151/255, blue: 186/255, alpha: 1.0).cgColor
                return configuredCell
            }
        case "Headers Cell":
            if let configuredCell = cell as? HeadersCardCell {
                configuredCell.configure()
                return configuredCell
            }
        default:
            return cell
        }

        return cell
//        return cellArray[indexPath.row] as! UITableViewCell
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

extension CardsViewController: UITextViewDelegate {
    
    @objc func updateCellHeight() {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.setContentOffset(currentOffset, animated: false)
    }

}

