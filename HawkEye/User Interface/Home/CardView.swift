//
//  CardView.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        _textView.text = title
        _textView.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(_textView)
        _textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        _textView.isEditable = false
        _textView.isSelectable = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let _textView: UITextView = {
        let textView = UITextView()
        return textView
    }()
}
