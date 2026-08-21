//
//  FrontCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct FrontCardView: View {
  let isFlipped: Bool
  let isBackSideShown: Bool
  let angle: Double
  let word: String
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(.whiteBlack)
      RoundedRectangle(cornerRadius: 15)
        .fill(.blue.gradient.quaternary)
        .shadow(color: .bluePan.opacity(0.5), radius: 10, x: 0, y: 10)
        .overlay(
          VStack(spacing: 20) {
            Text(word)
              .font(.title)
              .foregroundStyle(.bluePan)
              .multilineTextAlignment(.center)
          }
        )
    }
    .opacity(isBackSideShown ? 0 : 1)
    .rotation3DEffect(.degrees(angle), axis: (x: 1, y: 0, z: 0))
    
    
  }
}

#Preview {
  let word: String  = "Cat"
  FrontCardView(isFlipped: false, isBackSideShown: false, angle: 0, word: word)
    .frame(width: 300, height: 150)
}
