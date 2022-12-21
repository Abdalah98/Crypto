//
//  CircleButtonView.swift
//  Crypto
//
//  Created by Abdallah on 21/12/2022.
//

import SwiftUI

struct CircleButtonView: View {
  let iconName:String
    var body: some View {
        Image(systemName: iconName)
        .font(.headline)
        .foregroundColor(Color.colortheme.accent)
        .frame(width: 50,height: 50)
        .background(
          Circle()
            .foregroundColor(Color.colortheme.background)
        )
        .shadow(color: Color.colortheme.accent.opacity(0.25), radius:10,x: 0, y: 0)
        .padding()
    }
}

struct CircleButtonView_Previews: PreviewProvider {
    static var previews: some View {
      Group{
        CircleButtonView(iconName: "info")
          .previewLayout(.sizeThatFits)
        
        CircleButtonView(iconName: "plus")
          .previewLayout(.sizeThatFits)
          .preferredColorScheme(.dark)
      }
    }
}
