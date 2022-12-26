//
//  CoinImageServices.swift
//  Crypto
//
//  Created by Abdallah on 25/12/2022.
//

import Foundation
import SwiftUI
import Combine
class CoinImageServices {
  
  @Published var image : UIImage? = nil
  private  var imageSubscription: AnyCancellable?
  private let coin: CoinModel
  
  init(coin:CoinModel) {
    self.coin = coin
    getCoinImage()
  }
  
  func getCoinImage() {
      guard let url = URL(string:coin.image ?? "") else { return }
 
    imageSubscription = NetworkingManger.download(url: url)
      .tryMap({ (data) -> UIImage? in
        return UIImage(data: data)
      })
    
        
          .sink(receiveCompletion: NetworkingManger.handleCompletion,
         receiveValue: {[weak self] returnimage in
            self?.image = returnimage
            self?.imageSubscription?.cancel()
          })
 
  }
}
