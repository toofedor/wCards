//
//  FlipCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct FlipCardView: View {
  @StateObject var cardManager = CardManager()
    var body: some View {
      ZStack {
        FrontCardView(isFlipped: cardManager.isFlipped, angle: cardManager.rotationAngle, word: "Come")
        BackCardView(isFlipped: cardManager.isFlipped, angle: cardManager.rotationAngle, word: "Приходить")
      }
      .frame(width: 300, height: 150)
      .onTapGesture {
        cardManager.flipCard()
      }
    }
}

#Preview {
    FlipCardView()
}
