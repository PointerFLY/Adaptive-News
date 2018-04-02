//
//  ProfileViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    init() {
        super.init(style: .grouped)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        self.title = "ME"
        self.tableView.backgroundColor = G.UI.kViewColorDefault
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [3, 1][section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "User Name"
            cell.detailTextLabel?.text = AccountManager.shared.currentUser?.userName
            return cell
        case (0, 1):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Gender"
            cell.detailTextLabel?.text = AccountManager.shared.currentUser?.gender.description
        case (0, 2):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Age"
            cell.detailTextLabel?.text = AccountManager.shared.currentUser?.ageGroup.description
        case (1, 0):
            cell = UITableViewCell()
            cell.textLabel?.text = "Sign Out"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.red
        default:
            break
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (1, 0):
            let alertController = UIAlertController(title: "Are you sure?", message: "Local data will be restored when you sign in again. However, your local data may lost when another user signed in.", preferredStyle: .actionSheet)
            alertController.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
                AccountManager.shared.logout()
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        default:
            break
        }
    }
}
