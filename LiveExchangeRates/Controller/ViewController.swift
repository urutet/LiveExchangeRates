//
//  ViewController.swift
//  LiveExchangeRates
//
//  Created by Yushkevich Ilya on 20.02.22.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    // MARK: - Properties
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    // MARK: Public
    // MARK: Private
    private var rates: [ExchangeRate] = [] {
        didSet {
            exchangeRatesTable.reloadData()
        }
    }
    
    private var filteredRates: [ExchangeRate] = []
    private var isSearchEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !isSearchEmpty
    }
    
    private let exchangeRatesTable = UITableView()
    private let searchController = UISearchController()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        showActivityIndicator()
        NetworkManager.getRates {result in
            self.rates = result
            self.hideActivityIndicator()
        }
        exchangeRatesTable.register(ExchangeRateTableViewCell.self, forCellReuseIdentifier: "ExchangeRateTableViewCell")
        exchangeRatesTable.delegate = self
        exchangeRatesTable.dataSource = self
        searchController.searchResultsUpdater = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Exchange Rates"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        setupUI()
        addSubviews()
        addConstraints()
    }
    
    // MARK: - API
    // MARK: - Setups
    private func setupUI() {
        navigationController?.navigationBar.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)

        navigationItem.title = "Exchange Rates"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        exchangeRatesTable.backgroundColor = UIColor(red: 20/255, green: 18/255, blue: 29/255, alpha: 1.0)
        exchangeRatesTable.separatorStyle = .none
        exchangeRatesTable.rowHeight = UITableView.automaticDimension
        exchangeRatesTable.estimatedRowHeight = 212

    }
    
    private func addSubviews() {
        view.addSubview(exchangeRatesTable)
    }
    
    private func addConstraints() {
        exchangeRatesTable.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(view)
        }
    }
    // MARK: - Helpers
    private func showActivityIndicator() {
        view.isUserInteractionEnabled = false
        let viewController = tabBarController ?? navigationController ?? self
        activityIndicator.frame = CGRect(
            x: 0,
            y: 0,
            width: viewController.view.frame.width,
            height: viewController.view.frame.height)
        viewController.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        view.isUserInteractionEnabled = true
    }
    
    private func exchangeRateSearch(_ searchText: String) {
        filteredRates = rates.filter { $0.name.lowercased().contains(searchText.lowercased())
            
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredRates.count
        }
        
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = exchangeRatesTable.dequeueReusableCell(withIdentifier: "ExchangeRateTableViewCell") as? ExchangeRateTableViewCell {
            if isFiltering {
                cell.setProps(item: filteredRates[indexPath.row])
            } else {
                cell.setProps(item: rates[indexPath.row])
            }
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        exchangeRateSearch(searchController.searchBar.text ?? "")
        exchangeRatesTable.reloadData()
    }
}
