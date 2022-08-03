//
//  Networking.swift
//  LiveExchangeRates
//
//  Created by Yushkevich Ilya on 20.02.22.
//

import Foundation
import Alamofire

final class NetworkManager {
  static var baseURL = "https://rest.coinapi.io/v1/assets"
  static var key = "F2E6B284-A500-47B0-AF9A-EC381B4A9164"
  static var headers: HTTPHeaders = [
    "X-CoinAPI-Key" : key
  ]
  
  
  static func getRates(completion: @escaping ([ExchangeRate]) -> Void) {
    let request = AF.request(baseURL, headers: headers)
    request.responseData { response in
      switch response.result {
      case .success(let data):
        let cachedURLResponse = CachedURLResponse(response: response.response!, data: data)
        ExchangeRateCache.shared.pushRates(cachedResponse: cachedURLResponse, urlRequest: response.request!)
        completion(ExchangeRateCache.shared.pullRates(urlRequest: response.request!))
        
      case .failure(let error):
        print(error)
        completion(ExchangeRateCache.shared.pullRates(urlRequest: response.request!))
      }
    }
  }
}
