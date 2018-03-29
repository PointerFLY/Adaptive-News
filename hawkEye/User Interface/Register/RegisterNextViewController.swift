//
//  RegisterNextViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 29/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class RegisterNextViewController: UITableViewController {
    
    private var _registeringUser: RegisteringUser
    
    init(registeringUser: RegisteringUser) {
        _registeringUser = registeringUser
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Info"
        self.tableView.backgroundColor = G.UI.kViewColorDefault
        
        _registerButton.bk_addEventHandler({ _ in
            AccountManager.shared.register()
        }, for: .touchUpInside)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2, 6][section]
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
            cell.detailTextLabel?.text = _registeringUser.gender?.description
            cell.accessoryType = .disclosureIndicator
            return cell
        case (0, 1):
            cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
            cell.textLabel?.text = "Age"
            cell.detailTextLabel?.text = _registeringUser.ageGroup?.description
            cell.accessoryType = .disclosureIndicator
        default:
            cell = UITableViewCell()
            cell.textLabel?.text = "xxx"
            cell.textLabel?.textColor = UIColor.red
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 44 + 32
        }
        
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return _registerFooterView
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch (indexPath.section, indexPath.row) {
        case (0, 0):
            let viewController = GenderPickerViewController()
            viewController.didPickGenderHandler = { gender in
                self._registeringUser.gender = gender
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        case (0, 1):
            let viewController = AgeGroupPickerViewController()
            viewController.didPickAgeGroupHandler = { ageGroup in
                self._registeringUser.ageGroup = ageGroup
                self.tableView.reloadRows(at: [indexPath], with: .none)
            }
            self.navigationController?.pushViewController(viewController, animated: true)
        default:
            break
        }
    }
    
    private lazy var _registerFooterView: UIView = {
        let view = UIView()
        view.addSubview(_registerButton)
        view.isUserInteractionEnabled = true
        _registerButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(32)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
        return view
    }()

    private let _registerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        button.backgroundColor = G.UI.kThemeColor
        button.setTitle("Sign up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setBackgroundImage(UIImage.size(width: 1.0, height: 1.0).color(G.UI.kThemeColor).image, for: .normal)
        return button
    }()
}
