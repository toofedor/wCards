//
//  FlipCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct FlipCardView: View {
  @EnvironmentObject var allLangs: AllLanguages
  @StateObject var cardManager = CardManager()
  @State var card: Card
    var body: some View {
      ZStack {
        FrontCardView(isFlipped: card.flipped, isBackSideShown: cardManager.isBackSideShown, angle: cardManager.rotationAngle, word: card.word)
        BackCardView(isFlipped: card.flipped, isBackSideShown: cardManager.isBackSideShown, angle: cardManager.rotationAngle, word: card.translation)
      }
      .onTapGesture {
        cardManager.flipCardBouncy()
      }
    }
}

#Preview {
  FlipCardView(card: Card())
}
