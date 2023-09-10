//
//  CryptoViewController.swift
//  CoinValueApp
//
//  Created by Алексей Орловский on 27.08.2023.
//

import UIKit

class CryptoViewController: UIViewController {
    
    let tableView = UITableView()
    
    var cryptocurrencies: [CryptoData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupAddSubview()
        setupTableView()
        seetupViewDidLoad()
    }
    
    func seetupViewDidLoad() {
        title = "Crypto"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupAddSubview() {
        view.addSubview(tableView)
    }

    func setupTableView() {
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.frame = view.bounds
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    func fetchData() {
        CryptoCurrencyService.shared.fetchAllCryptocurrencies { [weak self] cryptocurrencies in
            self?.cryptocurrencies = cryptocurrencies.map {
                CryptoData(
                    id: $0.id,
                    name: $0.name,
                    symbol: $0.symbol,
                    image: $0.image,
                    currentPrice: $0.currentPrice,
                    priceChangePercentage24h: $0.priceChangePercentage24h)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

/// UITableViewDelegate & UITableViewDataSource
extension CryptoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptocurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else { fatalError() }
        cell.configure(with: cryptocurrencies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController = CryptoDetailsViewController()
        present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
