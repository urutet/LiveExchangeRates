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
  }
  
  // MARK: - Properties
  // MARK: Public
  // MARK: Private
  private let mainView = UIView()
  private let stackView = UIStackView()
  private let nameLabel = UILabel()
  private let rateLabel = UILabel()
  
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
    rateLabel.text = "$\(item.price_usd ?? 0.0)"
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
    mainView.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(10)
      make.top.equalTo(contentView).inset(5)
      make.height.equalTo(50)
    }
    
    stackView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
  // MARK: - Helpers
  override func setSelected(_ selected: Bool, animated: Bool) {
    //super.setSelected(selected, animated: animated)
  }
  
}
