//
//  HomeView.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

struct HomeView: View {
  
  @State private var showprotfolio:Bool = false
  
    var body: some View {
      ZStack{
        // background layer
        Color.colortheme.background
          .ignoresSafeArea()
        
        //content layer
        VStack{
            homeHeader
            Spacer(minLength: 0)
        }
      }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      NavigationView {
        HomeView()
          .navigationBarHidden(true)
      }
    }
}

extension HomeView{
  private var homeHeader: some View {
    HStack{
      CircleButtonView(iconName:showprotfolio ? "plus" : "info")
        .animation(.none)
        .background(
          CircleButtonAnimationView(animate: $showprotfolio)
        )
      Spacer()
      Text(showprotfolio ? "Protfolio" : "Live Prices")
        .font(.headline)
        .fontWeight(.heavy)
        .foregroundColor(Color.colortheme.accent)
        .animation(.none)
      Spacer()
      CircleButtonView(iconName: "chevron.right")
        .rotationEffect(Angle(degrees: showprotfolio ? 180 : 0))
        .onTapGesture {
          withAnimation(.spring()){
            showprotfolio.toggle()
          }
        }
    }
    .padding(.horizontal)
  }
}
