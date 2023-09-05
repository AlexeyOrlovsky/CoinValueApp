//
//  FavoritesCryptoViewController.swift
//  CoinValueAppDraft
//
//  Created by Алексей Орловский on 30.08.2023.
//

import UIKit
import SnapKit

class FavoritesCryptoViewController: UIViewController {
    
    /// UI Elements
    let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "star.leadinghalf.filled")
        image.tintColor = .systemPurple
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "RegBackground")
        view.addSubview(image)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        image.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(90)
        }
    }
}
