//
//  GenderPickerViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class GenderPickerViewController: UITableViewController {
    
    var didPickGenderHandler: ((Gender) -> Void)?
    
    private var _genders: [Gender] = [.male, .female, .other]
    private var _selectedIndex: Int?
    
    init(gender: Gender?) {
        super.init(style: .grouped)
        if let gender = gender {
            _selectedIndex = _genders.index(of: gender)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Gender"
        self.tableView.backgroundColor = G.UI.kViewColorDefault
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _genders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = _genders[indexPath.row].description
        if indexPath.row == _selectedIndex {
            cell.accessoryType = .checkmark
        }
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard _selectedIndex != indexPath.row else { return }

        if let selectedIndex = _selectedIndex {
            tableView.cellForRow(at: IndexPath(row: selectedIndex, section: 0))?.accessoryType = .none
        }
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        _selectedIndex = indexPath.row
        didPickGenderHandler?(_genders[_selectedIndex!]);
    }
}
