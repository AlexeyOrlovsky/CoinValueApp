//
//  CryptoDetailViewController.swift
//  CoinValueAppDraft
//
//  Created by Алексей Орловский on 30.08.2023.
//

import UIKit
import SnapKit

class CryptoDetailsViewController: UIViewController {
    
    /// UI Elements
    let label: UILabel = {
        let label = UILabel()
        label.text = "Details"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "RegBackground")
        view.addSubview(label)
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

