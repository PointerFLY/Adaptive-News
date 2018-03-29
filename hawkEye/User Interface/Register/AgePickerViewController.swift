//
//  AgePickerViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class AgePickerViewController: UITableViewController {
    
    private var _selectedIndex: Int? = nil
    
    init() {
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Age"
        self.tableView.backgroundColor = G.UI.kViewColorDefault
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "10 - 19"
        if indexPath.row == _selectedIndex {
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

}
