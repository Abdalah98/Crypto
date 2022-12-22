//
//  CoinDataServices.swift
//  Crypto
//
//  Created by Abdallah on 22/12/2022.
//

import Foundation
import Combine
class CoinDataServices{
  
     @Published var allCoins: [CoinModel] = []
     
     var coinSubscription: AnyCancellable?
     
     init() {
         getCoins()
     }
     
  func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    coinSubscription = NetworkingManger.download(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
    
      .sink(receiveCompletion: NetworkingManger.handleCompletion,
            receiveValue: {[weak self] returnCoins in
        self?.allCoins = returnCoins
      })
    
  }
}
