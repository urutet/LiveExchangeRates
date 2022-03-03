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
        AF.request(baseURL, headers: headers).responseDecodable(of: [ExchangeRate].self) { response in
            switch response.result {
            case .success(let model):
                completion(model)
                print(model)
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
