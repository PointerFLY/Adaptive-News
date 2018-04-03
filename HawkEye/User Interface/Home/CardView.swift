//
//  CardView.swift
//  HawkEye
//
//  Created by PointerFLY on 02/04/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Kingfisher

class CardView: UIView {
    
    init(title: String, tag: String, imageURL: URL?) {
        _textView.text = String(format: "[%@]:  %@", tag, title)
        _imageView.kf.setImage(with: imageURL)

        super.init(frame: CGRect.zero)
        self.layer.cornerRadius = 8.0
        self.clipsToBounds = true
        self.backgroundColor = UIColor.white
        
        self.addSubview(_textView)
        self.addSubview(_imageView)

        _textView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(120)
        }
        _imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(_textView.snp.top).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let _imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let _textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.boldSystemFont(ofSize: 20)
        textView.isScrollEnabled = false
        return textView
    }()
}
