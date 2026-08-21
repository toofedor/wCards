//
//  StackView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct StackView: View {
  @EnvironmentObject var allLangs: AllLanguages
  @Binding var cardSet: CardSet

  @State private var dragOffset: CGSize = .zero
  @State private var topCardIndex: Int = 0
  @State var refresh: Bool = false
  var width: CGFloat = 300

  var body: some View {
    ZStack {
      ForEach(cardSet.setOfCards, id: \.id) { card in
        cardView(card, at: cardSet.index(card: card))
      }
      .padding()
      
      }
    .background{
//      Color.black
      Text(cardSet.name)
        .lineLimit(1)
        .font(.system(size: 240, weight: .black, design: .serif))
        .foregroundStyle(.gray.gradient.quaternary)
        .frame(width: 2000, height: 1000)
        .rotationEffect(.degrees(-70))
        
    }
    .onChange(of: cardSet.name) { oldValue, newValue in
      refresh.toggle()
    }
  }

  @ViewBuilder
  private func cardView(_ card: Card, at index: Int) -> some View {
    let visualIndex = (index - topCardIndex + cardSet.setOfCards.count) % cardSet.setOfCards.count
    let progress = min(abs(dragOffset.width) / 150, 1)
    let signedProgress = (dragOffset.width >= 0 ? 1 : -1) * progress

    FlipCardView(card: card)
      .frame(width: width, height: 150)
      .offset(
        x: offsetFor(visualIndex: visualIndex, dragOffset: dragOffset.width),
        y: yOffsetFor(visualIndex: visualIndex)
      )
      .zIndex(Double(cardSet.setOfCards.count - visualIndex))
      .rotationEffect(
        .degrees(rotationFor(visualIndex: visualIndex, progress: progress)),
        anchor: .bottom
      )
      .scaleEffect(scaleFor(visualIndex: visualIndex, progress: progress))
      .offset(x: offsetXBackFor(visualIndex: visualIndex))
      .rotation3DEffect(
        .degrees(rotation3DFor(visualIndex: visualIndex, signedProgress: signedProgress)),
        axis: (0, 1, 0)
      )
      .contentShape(Rectangle())
      .gesture(dragGesture)
  }

  // MARK: - Helper functions for layout

  private func offsetFor(visualIndex: Int, dragOffset: CGFloat) -> CGFloat {
    visualIndex == 0 ? dragOffset : Double(visualIndex) * -20
  }

  private func yOffsetFor(visualIndex: Int) -> CGFloat {
    visualIndex == 0 ? 0 : Double(visualIndex) * 5
  }

  private func rotationFor(visualIndex: Int, progress: Double) -> Double {
    visualIndex == 0 ? 0 : (Double(visualIndex) - progress) * 5.0
  }

  private func scaleFor(visualIndex: Int, progress: Double) -> CGFloat {
    switch visualIndex {
    case 0:
      return 1
    case 1:
      return 1.0 - (Double(visualIndex) + progress) * 0.06
    default:
      return 1.0 - Double(visualIndex) * 0.06
    }
  }

  private func offsetXBackFor(visualIndex: Int) -> CGFloat {
    visualIndex == 0 ? 0 : Double(visualIndex) * 10
  }

  private func rotation3DFor(visualIndex: Int, signedProgress: Double) -> Double {
    20.0 * signedProgress * (1.0 - (Double(visualIndex) + signedProgress) * 0.1)
  }

  // MARK: - Gesture

  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { value in
        dragOffset = value.translation
      }
      .onEnded { value in
        handleSwipe(value: value)
      }
  }

  private func handleSwipe(value: DragGesture.Value) {
    let threshold: CGFloat = 50

    if abs(value.translation.width) > threshold {
      let direction = value.translation.width < 0 ? -1 : 1
      let delay: Double = direction == -1 ? 0.18 : 0.20

      withAnimation(.smooth(duration: delay)) {
        dragOffset.width = direction < 0 ? -width * 1.05 : width
      } completion: {
        withAnimation(.smooth(duration: 0.5)) {
          topCardIndex = (topCardIndex + 1) % cardSet.setOfCards.count
          dragOffset = .zero
        }
      }
    } else {
      withAnimation {
        dragOffset = .zero
      }
    }
  }
}

#Preview {
  @Previewable @State var stack = CardSet(
    name: "Animals", setOfCards: [
      Card(word: "Cat", translation: "Кот"), 
      Card(word: "Dog", translation: "Собака"), 
      Card(word: "Mouse", translation: "Мышь"), 
      Card(word: "Bat", translation: "Летучая мышь"), 
      Card(word: "Snake", translation: "Змея")
    ]
  )
  StackView(cardSet: $stack)
}
