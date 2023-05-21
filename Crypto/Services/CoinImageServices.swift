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
  private let fileManager = LocalFileManger.instance
  private let folderName = "coin_images"
  private let iamgeName :String

  
  init(coin:CoinModel) {
    self.coin = coin
    self.iamgeName = coin.id
    getCoinImage()
  }
  
  
  private func getCoinImage(){
    if let  savedIamge =   fileManager.getImage(imageName: iamgeName, folderName: folderName){
      image = savedIamge
    }else{
      downloadCoinImage()
    }
  }
  
  func downloadCoinImage() {
      guard let url = URL(string:coin.image ?? "") else { return }
 
    imageSubscription = NetworkingManger.download(url: url)
      .tryMap({ (data) -> UIImage? in
        return UIImage(data: data)
      })
    
        
          .sink(receiveCompletion: NetworkingManger.handleCompletion,
         receiveValue: {[weak self] returnimage in
            guard let self = self , let dowloadImage = returnimage else {return}
            self.image = returnimage
            self.imageSubscription?.cancel()
            self.fileManager.saveImage(image: dowloadImage, imageName: iamgeName, folderName: folderName)
          })
 
  }
}
