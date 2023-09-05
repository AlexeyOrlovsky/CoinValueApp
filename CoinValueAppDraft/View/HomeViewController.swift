//
//  HomeViewController.swift
//  CoinValueApp
//
//  Created by Алексей Орловский on 27.08.2023.
//

import UIKit
import SnapKit
import SwiftyJSON

class HomeViewController: UIViewController {
    
    let tableView = UITableView()
    
    var cryptocurrencies = [CryptoData]()
    
    /// UI Elements
    let converterContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .quaternaryLabel
        view.layer.cornerRadius = 20
        return view
    }()
    
    let titleFieldHave: UILabel = {
        let label = UILabel()
        label.text = "I have"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let quantitativelyHave: UITextField = {
        let textField = UITextField()
        textField.placeholder = "100"
        textField.font = .systemFont(ofSize: 36, weight: .semibold)
        textField.textColor = .label
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let titleFieldGet: UILabel = {
        let label = UILabel()
        label.text = "I will get"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let quantitativelyGet: UITextField = {
        let textField = UITextField()
        textField.placeholder = "3700"
        textField.font = .systemFont(ofSize: 36, weight: .semibold)
        textField.textColor = .label
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let containerIHaveCurrency: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let iHaveCurrency: UILabel = {
        let label = UILabel()
        label.text = "USD"
        return label
    }()
    
    let containerIWantCurrency: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 10
        return view
    }()
    
    let iWantCurrency: UILabel = {
        let label = UILabel()
        label.text = "UAH"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAddSubview()
        setupTableView()
        setupViewDidLoad()
    }
    
    func setupViewDidLoad() {
        view.backgroundColor = .systemBackground
        title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .done, target: self, action: #selector(rightBarButtonAction))
        navigationItem.rightBarButtonItem?.tintColor = .systemPurple
        
        quantitativelyHave.delegate = self
        quantitativelyGet.delegate = self
    }
    
    func setupAddSubview() {
        view.addSubview(tableView)
        
        view.addSubview(converterContainer)
        converterContainer.addSubview(titleFieldHave)
        converterContainer.addSubview(quantitativelyHave)
        
        converterContainer.addSubview(containerIHaveCurrency)
        containerIHaveCurrency.addSubview(iHaveCurrency)
        
        converterContainer.addSubview(titleFieldGet)
        converterContainer.addSubview(quantitativelyGet)
        
        converterContainer.addSubview(containerIWantCurrency)
        containerIWantCurrency.addSubview(iWantCurrency)
        
        quantitativelyHave.addTarget(self, action: #selector(currencyConversionHave), for: .editingChanged)
        quantitativelyGet.addTarget(self, action: #selector(currencyConversionGet), for: .editingChanged)
    }
    
    func setupTableView() {
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchData()
    }
    
    /// Constraints
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        converterContainer.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(120)
            make.width.equalTo(360)
            make.height.equalTo(200)
        }
        
        titleFieldHave.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.left.equalToSuperview().inset(20)
        }
        
        quantitativelyHave.snp.makeConstraints { make in
            make.top.equalTo(titleFieldHave.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(300)
        }
        
        containerIHaveCurrency.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(quantitativelyHave.snp.centerY)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        iHaveCurrency.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleFieldGet.snp.makeConstraints { make in
            make.top.equalTo(quantitativelyHave.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        quantitativelyGet.snp.makeConstraints { make in
            make.top.equalTo(titleFieldGet.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.width.equalTo(300)
        }
        
        containerIWantCurrency.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalTo(quantitativelyGet.snp.centerY)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        iWantCurrency.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(converterContainer.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
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

/// @objc funcs
extension HomeViewController {
    
    @objc func currencyConversionHave() {
        if quantitativelyHave.text != "" {
            if let intValue = Int(quantitativelyHave.text ?? "") {
                let multipliedValue = intValue * 37
                quantitativelyGet.text = String(multipliedValue)
            } else {
                print("No possible to convert")
            }
        } else {
            quantitativelyGet.text = ""
        }
    }
    
    @objc func currencyConversionGet() {
        if quantitativelyGet.text != "" {
            if let intValue = Int(quantitativelyGet.text ?? "") {
                let multipliedValue = intValue / 37
                quantitativelyHave.text = String(multipliedValue)
            } else {
                print("No possible to convert")
            }
        } else {
            quantitativelyHave.text = ""
        }
    }
    
    @objc func rightBarButtonAction() {
        let viewController = FavoritesCryptoViewController()
        present(viewController, animated: true)
    }
}

/// UITextFieldDelegate
extension HomeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.count + string.count - range.length
        return newLength <= 8
    }
}


