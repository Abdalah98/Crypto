//
//  CryptoApp.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

@main
struct CryptoApp: App {
    var body: some Scene {
        WindowGroup {
          NavigationView {
            HomeView()
              .navigationBarHidden(true)
          }
        }
    }
}
