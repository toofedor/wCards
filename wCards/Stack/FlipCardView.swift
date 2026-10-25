//
//  FlipCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct FlipCardView: View {
  @StateObject var cardManager = CardManager()
  @State var card: Card
  @State var propect: Bool = false
    var body: some View {
      ZStack {
        FrontCardView(isFlipped: card.flipped, isBackSideShown: cardManager.isBackSideShown, angle: cardManager.rotationAngle, word: card.word, isOn: $card.pointed)
        BackCardView(isFlipped: card.flipped, isBackSideShown: cardManager.isBackSideShown, angle: cardManager.rotationAngle, word: card.translation, isOn: $card.pointed)
      }
      .onTapGesture {
        cardManager.flipCardBouncy(tapped: true)
        propect = true
        card.flipped.toggle()
        Task {
          try await Task.sleep(nanoseconds: 100)
          propect = false
        }
      }
      .onChange(of: card.flipped) { oldValue, newValue in
        if propect {
          propect.toggle()
        } else {
          if card.flipped != cardManager.isBackSideShown {
            cardManager.flipCardBouncy()
          }
        }
      }
    }
}

#Preview {
  FlipCardView(card: Card())
}
