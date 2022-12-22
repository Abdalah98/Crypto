//
//  NeworkingManger.swift
//  Crypto
//
//  Created by Abdallah on 22/12/2022.
//

import Foundation
import Combine

class NetworkingManger{
  
  enum NetworkingManger:LocalizedError {
    case badURLResponse(url:URL)
    case unknown
    
    var errorDescription: String?{
      switch self{
      case .badURLResponse(url: let url): return "[🔥] Bad response from URL: \(url)"
       case .unknown: return "[⚠️] Unknown error occured"
      }
    }
  }
  static func download (url:URL) -> AnyPublisher<Data, Error> {
    
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos:.default))
      .tryMap({try handleUrlResponse(output: $0,url: url)})
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  static func handleUrlResponse(output:URLSession.DataTaskPublisher.Output,url:URL) throws -> Data{
    guard let response =  output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300
    else{
      throw  NetworkingManger.badURLResponse(url: url)
    }
    return output.data
  }
  
  
  static func handleCompletion(completion:Subscribers.Completion<Error>){
    switch completion{
    case .finished:
      break
    case .failure(let err):
      print(err.localizedDescription)
    }
  }
}
