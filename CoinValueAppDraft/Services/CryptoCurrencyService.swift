//
//  CryptoCurrencyService.swift
//  CoinValueAppDraft
//
//  Created by Алексей Орловский on 30.08.2023.
//

import UIKit

class CryptoCurrencyService {
    static let shared = CryptoCurrencyService()
    
    var cryptocurrencies: [CryptoData] = []
    
    func fetchAllCryptocurrencies(completion: @escaping ([Cryptocurrency]) -> Void) {
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=true"
        
        guard let url = URL(string: urlString) else {
            completion([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion([])
                return
            }
            
            if let data = data {
                do {
                    let cryptocurrencies = try JSONDecoder().decode([Cryptocurrency].self, from: data)
                    completion(cryptocurrencies) // Исправлено
                } catch {
                    print("JSON decoding error: \(error)")
                    completion([])
                }
            }
        }.resume()
    }
}
