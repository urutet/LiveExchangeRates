//
//  Rate.swift
//  LiveExchangeRates
//
//  Created by Yushkevich Ilya on 20.02.22.
//

import Foundation

struct ExchangeRate: Codable {
    let name: String
    let price_usd: Double?
}
