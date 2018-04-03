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
import Alamofire
import SwiftSoup
import RealmSwift

class HomeViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    
    private let _kolodaView = KolodaView()
    private var _newsList = [News]()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        for _ in 0..<5 {
            pushNews()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func pushNews() {
        let tag = AccountManager.shared.userModel!.nextTag
        let news = NewsProvider.shared.getNews(tag: tag)
        _newsList.append(news)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
        setupEvents()
    }
    
    
    private func setupNavigation() {
        self.title = "HawkEye NEWS"
        let rightItem = UIBarButtonItem()
        rightItem.bk_init(with: UIImage(named: "btn_me")!, style: .plain) { _ in
            self.navigationController?.pushViewController(ProfileViewController(), animated: true);
        }
        self.navigationItem.rightBarButtonItem = rightItem
        let leftItem = UIBarButtonItem()
        leftItem.bk_init(with: UIImage(named: "btn_record")!, style: .plain) { _ in
            self.navigationController?.pushViewController(ModelRecordViewController(), animated: true)
        }
        self.navigationItem.leftBarButtonItem = leftItem
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
    
    private func setupEvents() {
        _dislikeButton.bk_addEventHandler({ [unowned self] _ in
            self._kolodaView.swipe(.left)
        }, for: .touchUpInside)
        _likeButton.bk_addEventHandler({ [unowned self] _ in
            self._kolodaView.swipe(.right)
        }, for: .touchUpInside)
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
    
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        pushNews()
        let tag = _newsList[index].tag
        if direction == .left {
            AccountManager.shared.userModel?.dislike(tag: tag)
        } else if direction == .right {
            AccountManager.shared.userModel?.like(tag: tag)
        } else {
            Log.error("Error swipe direction")
        }
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        let viewController = SFSafariViewController(url: _newsList[index].url)
        self.present(viewController, animated: true, completion: nil)
    }
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return Int.max
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let news = _newsList[index]
        let cardView = CardView(title: news.title, tag: news.tag, imageURL: news.imageURL)
        return cardView
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let view = CustomOverlayView()
        return view
    }
}
