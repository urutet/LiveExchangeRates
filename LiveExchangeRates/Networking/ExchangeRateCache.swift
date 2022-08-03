//
//  ExchangeRateCache.swift
//  LiveExchangeRates
//
//  Created by Yushkevich Ilya on 3.08.22.
//

import Foundation

final class ExchangeRateCache {
  static let shared = ExchangeRateCache()
  
  let cache = URLCache(memoryCapacity: 5*1024, diskCapacity: 5*1024, directory: nil)
  let jsonDecoder = JSONDecoder()
  
  private init() { }
  
  func pushRates(cachedResponse: CachedURLResponse, urlRequest: URLRequest) {
    cache.storeCachedResponse(cachedResponse, for: urlRequest)
  }
  
  func pullRates(urlRequest: URLRequest) -> [ExchangeRate] {
    var exchangeRates = [ExchangeRate]()
    guard let data = cache.cachedResponse(for: urlRequest)?.data else { return exchangeRates }
    
    do {
      exchangeRates = try jsonDecoder.decode([ExchangeRate].self, from: data)
    } catch let error {
      print(error)
    }
    
    return exchangeRates
  }
}
