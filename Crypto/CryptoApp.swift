//
//  CryptoApp.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

@main
struct CryptoApp: App {
  
  @StateObject private var vm :HomeViewModel = HomeViewModel()
  
    var body: some Scene {
        WindowGroup {
          NavigationView {
            HomeView()
              .navigationBarHidden(true)
          }
          .environmentObject(vm)
        }
    }
}
