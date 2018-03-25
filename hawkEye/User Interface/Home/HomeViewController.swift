//
//  HomeViewController.swift
//  hawkEye
//
//  Created by PointerFLY on 23/03/2018.
//  Copyright © 2018 PointerFLY. All rights reserved.
//

import UIKit
import Koloda

class HomeViewController: UIViewController, KolodaViewDelegate, KolodaViewDataSource {
    
    private let _kolodaView = KolodaView()
    
    override func loadView() {
        self.view = _kolodaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupUI()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "HawkEye NEWS"
        let item = UIBarButtonItem()
        item.bk_init(with: UIImage(named: "btn_me")!, style: .plain) { _ in
            self.navigationController?.pushViewController(ProfileViewController(), animated: true);
        }
        self.navigationItem.rightBarButtonItem = item
    }
    
    private func setupUI() {
        self.view.backgroundColor = G.UI.kViewColorDefault
        
        _kolodaView.dataSource = self
        _kolodaView.delegate = self
    }
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        koloda.reloadData()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    let images = [
        UIImage.size(width: 1.0, height: 1.0).color(.red).image,
        UIImage.size(width: 1.0, height: 1.0).color(.green).image,
        UIImage.size(width: 1.0, height: 1.0).color(.blue).image,
        UIImage.size(width: 1.0, height: 1.0).color(.cyan).image,
        UIImage.size(width: 1.0, height: 1.0).color(.yellow).image,
        UIImage.size(width: 1.0, height: 1.0).color(.purple).image,
        UIImage.size(width: 1.0, height: 1.0).color(.orange).image,
        UIImage.size(width: 1.0, height: 1.0).color(.brown).image,
        UIImage.size(width: 1.0, height: 1.0).color(.gray).image,
        UIImage.size(width: 1.0, height: 1.0).color(.magenta).image
    ]
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        return images.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: images[index])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        let view = OverlayView()
        view.backgroundColor = UIColor.red
        return view
    }
}
