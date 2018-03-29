//
//  HomeViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Koloda
import SafariServices

class HomeViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    
    private let _kolodaView = KolodaView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        self.title = "HawkEye NEWS"
        let item = UIBarButtonItem()
        item.bk_init(with: UIImage(named: "btn_me")!, style: .plain) { _ in
            self.navigationController?.pushViewController(ProfileViewController(), animated: true);
        }
        self.navigationItem.rightBarButtonItem = item
    }
    
    private func setupUI() {
        self.view.backgroundColor = G.UI.kViewColorDefault
        
        self.view.addSubview(_kolodaView)
        self.view.addSubview(_dislikeButton)
        self.view.addSubview(_likeButton)
        
        _kolodaView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(18)
            make.left.equalTo(self.view).offset(24)
            make.right.equalTo(self.view).offset(-24)
            make.bottom.equalTo(self.view).offset(-120)
        }
        _dislikeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.left.equalTo(self.view).offset(80)
        }
        _likeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.snp.bottom).offset(-20)
            make.width.equalTo(80)
            make.height.equalTo(80)
            make.right.equalTo(self.view).offset(-80)
        }
        
        _kolodaView.dataSource = self
        _kolodaView.delegate = self
    }
    
    private let _dislikeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_dislike"), for: .normal)
        return button
    }()
    
    private let _likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "btn_like"), for: .normal)
        return button
    }()
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let viewController = SFSafariViewController(url: URL(string: "https://www.theguardian.com/uk-news/2018/mar/26/four-eu-states-set-to-expel-russian-diplomats-over-skripal-attack")!)
        self.present(viewController, animated: true, completion: nil)
    }
    
    let images: [UIImage] = {
        var images = [UIImage]()
        for _ in 1...1000 {
            let image = UIImage.size(CGSize(width: 1.0, height: 1.0)).color(.red).image
            images.append(image)
        }
        return images
    }()
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let imageView = UIImageView(image: images[index])
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let view = OverlayView()
        view.backgroundColor = UIColor.cyan.alpha(0.5)
        return view
    }
}
