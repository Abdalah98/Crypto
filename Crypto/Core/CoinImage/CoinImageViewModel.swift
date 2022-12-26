//
//  CoinImageViewModel.swift
//  Crypto
//
//  Created by Abdallah on 25/12/2022.
//

import Foundation
import SwiftUI
import Combine
class CoinImageViewModel:ObservableObject{
  
  @Published var image:UIImage? = nil
  @Published var isLoading     = false
  
  private let  coin:CoinModel
  private let dataServices: CoinImageServices
  private var cancellable  = Set<AnyCancellable>()
  
  init(coin:CoinModel){
    self.coin = coin
    self.dataServices = CoinImageServices(coin: coin)
    self.addSubscribers()
    self.isLoading = true
  }
  
  private func  addSubscribers(){
    dataServices.$image
      .sink { [weak self] _ in
        self?.isLoading = false
      } receiveValue: {[weak self] returnImage in
        self?.image = returnImage
      }
      .store(in: &cancellable)

  }
}
