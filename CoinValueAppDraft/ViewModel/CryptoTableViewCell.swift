//
//  CryptoTableViewCell.swift
//  CoinValueApp
//
//  Created by Алексей Орловский on 28.08.2023.
//

import UIKit
import SnapKit
import SDWebImage

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    /// UI Elements
    let name: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    let priceChangePercentage24h: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(price)
        contentView.addSubview(priceChangePercentage24h)
    }
    
    /// Constraints
    override func layoutSubviews() {
        super.layoutSubviews()
        
        image.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        name.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(image.snp.right).offset(10)
        }
        
        price.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(10)
        }
        
        priceChangePercentage24h.snp.makeConstraints { make in
            make.top.equalTo(price.snp.bottom).offset(4)
            make.right.equalToSuperview().inset(10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with crypto: CryptoData) {
        name.text = crypto.name
        
        price.text = String(format: "%.2f$", (crypto.currentPrice))
        if let imageURL = URL(string: crypto.image) {
            image.sd_setImage(with: imageURL, completed: nil)
        }
        priceChangePercentage24h.text = String(format: "%.2f%%", (crypto.priceChangePercentage24h))
        if let text = priceChangePercentage24h.text {
            if text.contains("-") {
                priceChangePercentage24h.textColor = UIColor.systemRed
            } else {
                priceChangePercentage24h.textColor = UIColor.systemGreen
            }
        }
    }
}
