//
//  HomeViewModel.swift
//  Crypto
//
//  Created by Abdallah on 22/12/2022.
//

import Foundation
import Combine

class HomeViewModel :ObservableObject{
  
  @Published var allCoins : [CoinModel] =  []
  @Published var protfoliCoins : [CoinModel] =  []
  
  private let dataServices = CoinDataServices()
  private var cancellables = Set<AnyCancellable>()

  init() {
    addSubscribers()
  }
  
  func addSubscribers(){
    dataServices.$allCoins.sink { [weak self] returnCoins in
      self?.allCoins = returnCoins
    }
    .store(in: &cancellables)
  }
}
