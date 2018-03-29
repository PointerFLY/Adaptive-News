//
//  RegisterNextViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class RegisterNextViewController: UITableViewController {
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Info"
        self.tableView.backgroundColor = G.UI.kViewColorDefault
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2, 7][section]
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Personal info", "Topics you like"][section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = KeyValueStore.userName
            return cell
        case (0, 1):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Age"
            cell.detailTextLabel?.text = KeyValueStore.gender?.description
        default:
            cell = UITableViewCell()
            cell.textLabel?.text = "Sign Out"
            cell.textLabel?.textColor = UIColor.red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let viewController = GenderPickerViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        case (0, 1):
            let viewController = AgePickerViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
}
