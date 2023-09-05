//
//  CryptoData.swift
//  CoinValueApp
//
//  Created by Алексей Орловский on 28.08.2023.
//

import Foundation

struct Cryptocurrency: Codable {
    let id: String
    let name: String
    let symbol: String
    let image: String
    let currentPrice: Double
    let priceChangePercentage24h: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case image
        case currentPrice = "current_price"
        case priceChangePercentage24h = "price_change_percentage_24h" // Имя ключа в JSON
    }
}

struct CryptoData {
    var id: String
    var name: String
    var symbol: String
    var image: String
    var currentPrice: Double
    var priceChangePercentage24h: Double
}
