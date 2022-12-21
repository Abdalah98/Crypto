//
//  CoinRowView.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

struct CoinRowView: View {
  
  let coin : CoinModel
  let showHoldingsColum:Bool
    var body: some View {
      
      HStack(spacing: 0){
        leftColumn
        Spacer()
        if showHoldingsColum{
          centerColumn
        }
        rightColumn
      }
      .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        CoinRowView(coin: dev.coin,showHoldingsColum: true)
          .previewLayout(.sizeThatFits)
        
        CoinRowView(coin: dev.coin,showHoldingsColum: true)
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    
    }
}

extension CoinRowView {
  
  private var leftColumn: some View {
    HStack(spacing:0){
      Text("\(coin.rank)")
        .font(.caption)
        .foregroundColor(Color.colortheme.secondryText)
        .frame(minWidth:  30)
      Circle()
        .frame(width: 30,height: 30)
      Text(coin.symbol?.uppercased() ?? ""  )
        .font(.headline)
        .padding(.leading,  6)
        .foregroundColor(Color.colortheme.accent)
    }
  }
  
  private  var centerColumn: some View {
    VStack(alignment: .trailing){
      Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
        .bold()
      Text((coin.currentHoldings ?? 0).asNumberString() )
    }
    .foregroundColor(Color.colortheme.accent)
  }

private  var rightColumn: some View {
       VStack(alignment: .trailing){
         Text(coin.currentPrice.asCurrencyWith6Decimals())
           .bold()
           .foregroundColor(Color.colortheme.accent)
         Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
           .foregroundColor(
             (coin.priceChangePercentage24H ?? 0) >= 0 ?
             Color.colortheme.green :
               Color.colortheme.red
           )
       }
       .frame(width: UIScreen.main.bounds.width / 3.5,alignment: .trailing)
     }
    
}
