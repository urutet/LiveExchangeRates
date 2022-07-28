//
//  ExchangeRateTableViewCell.swift
//  LiveExchangeRates
//
//  Created by Yushkevich Ilya on 20.02.22.
//

import UIKit
import SnapKit

final class ExchangeRateTableViewCell: UITableViewCell {
  
  private enum Constants {
    static let cellColor = "ExchangeRateCell"
    static let rateFormat = "$ %.3f"
  }
  
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private let mainView = UIView()
  private let stackView = UIStackView()
  private let nameLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .left
    
    return label
  }()
  
  private let rateLabel: UILabel = {
    let label = UILabel()
    
    label.textAlignment = .right
    
    return label
  }()
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
    addSubviews()
    addConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    mainView.layer.cornerRadius = 5
  }
  // MARK: - API
  func setProps(item: ExchangeRate) {
    nameLabel.text = item.name
    
    guard let price = item.price_usd else { return }
    
    rateLabel.text = String(format: Constants.rateFormat, price)
  }
  
  // MARK: - Setups
  private func setupUI() {
    contentView.backgroundColor = .none
    mainView.backgroundColor = UIColor(named: Constants.cellColor)
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
  }
  
  private func addSubviews() {
    contentView.addSubview(mainView)
    mainView.addSubview(stackView)
    stackView.addArrangedSubview(nameLabel)
    stackView.addArrangedSubview(rateLabel)
  }
  
  private func addConstraints() {
    contentView.snp.makeConstraints { make in
      make.height.equalTo(70)
      make.leading.trailing.equalToSuperview().inset(5)
    }
    
    mainView.snp.makeConstraints { make in
      make.top.bottom.leading.trailing.equalTo(contentView).inset(5)
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview().inset(10)
    }
  }
  
  // MARK: - Helpers
  override func setSelected(_ selected: Bool, animated: Bool) {
    //super.setSelected(selected, animated: animated)
  }
  
}
