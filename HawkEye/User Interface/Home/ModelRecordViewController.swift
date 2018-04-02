//
//  ModelRecordViewController.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class ModelRecordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Model Record"
        self.view.backgroundColor = G.UI.kViewColorDefault
        
        self.view.addSubview(_textView)
        _textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        _textView.text = ModelRecord.shared.currentLog
    }
    
    private var _textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = G.UI.kViewColorDefault
        return textView
    }()
}
