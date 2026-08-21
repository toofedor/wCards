//
//  BackCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct BackCardView: View {
  let isFlipped: Bool
  let isBackSideShown: Bool
  let angle: Double
  let word: String
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(.whiteBlack)
      RoundedRectangle(cornerRadius: 15)
        .fill(.green.gradient.quaternary)
        .shadow(color: .greenPan.opacity(0.5), radius: 10, x: 0, y: 10)
        .overlay(
          VStack(spacing: 20) {
            Text(word)
              .font(.title)
              .foregroundStyle(.greenPan)
              .multilineTextAlignment(.center)
              .padding()
          }
        )
    }
    .opacity(isBackSideShown ? 1 : 0)
    .rotation3DEffect(.degrees(angle - 180), axis: (x: 1, y: 0, z: 0))
    
  }
}

#Preview {
  let word: String  = "Кот"
  BackCardView(isFlipped: true, isBackSideShown: true, angle: 180, word: word)
    .frame(width: 300, height: 150)
}
