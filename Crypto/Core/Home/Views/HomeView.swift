//
//  HomeView.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

struct HomeView: View {
  
  @EnvironmentObject private var vm :HomeViewModel
  @State private var showprotfolio:Bool = false
  
    var body: some View {
      ZStack{
        // background layer
        Color.colortheme.background
          .ignoresSafeArea()
        
        //content layer
        VStack{
            homeHeader
          
          columTitles
       
          
          if !showprotfolio{
            allCoinsList
            .transition(.move(edge: .leading))
          }
          
          if showprotfolio{
            protfolioCoinsList
              .transition(.move(edge: .trailing))

          }
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
      }.environmentObject(dev.homevm)
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
  private var allCoinsList : some View{
    List{
      ForEach(vm.allCoins){ coin in
        CoinRowView(coin: coin, showHoldingsColum: false)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  
  private var protfolioCoinsList : some View{
    List{
      ForEach(vm.allCoins){ coin in
        CoinRowView(coin: coin, showHoldingsColum: true)
          .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
      }
    }
    .listStyle(PlainListStyle())
  }
  
  private var columTitles: some View{
    HStack{
      Text("Coin")
      Spacer()
      if showprotfolio{
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)

    }
    .font(.caption)
    .foregroundColor(Color.colortheme.secondryText)
    .padding(.horizontal)
  }
}
