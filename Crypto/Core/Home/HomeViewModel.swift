//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Abdallah on 22/12/2022.
//

import Foundation
class HomeViewModel :ObservableObject{
  
  @Published var allCoins : [CoinModel] =  []
  @Published var protfoliCoins : [CoinModel] =  []

  init() {
    DispatchQueue.main.asyncAfter(deadline: .now() ){
      self.allCoins.append(DeveloperProvider.instance.coin)
      self.protfoliCoins.append(DeveloperProvider.instance.coin)

    }
  }
  
}
