//
//  StackView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct StackView: View {
  @Binding var cardSet: CardSet

  @State private var dragOffset: CGSize = .zero
  @State private var topCardIndex: Int = 0
  @State private var len: Int = 1
  @State private var shiftFactor: Double = 1
  var width: CGFloat = 350

  var body: some View {
    ZStack {
      ForEach(cardSet.setOfCards, id: \.id) { card in
        cardView(card)
      }
      .padding()
      VStack{
        Spacer()
        HStack(alignment: .bottom) {
          Button {
            flipCards(direction: .up)
          } label: {
            Image(systemName: "arrow.uturn.up.square")
            Text("Face Up")
          }
          .buttonStyle(.glassProminent)
          Button {
            flipCards(direction: .down)
          } label: {
            Image(systemName: "arrow.uturn.down.square")
            Text("Face Down")
          }
          .buttonStyle(.glassProminent)
        }
        .font(.title2)
      }
    }
    .background {
      Text(cardSet.name)
        .lineLimit(1)
        .font(.system(size: 1500 / Double(cardSet.name.count), weight: .black, design: .serif))
        .foregroundStyle(.gray.gradient.quaternary)
        .frame(width: 2000, height: 1000)
        .rotationEffect(.degrees(-70))
    }
    .onAppear {
      len = cardSet.setOfCards.count
      shiftFactor = 0.2 + 3.5/Double(len)
    }
  }
  
  
  func flipCards(direction: Direction) {
    let n = cardSet.setOfCards.count { $0.flipped == (direction == .up) }
    guard n != 0 else { return }
    let nanoSec: UInt64 = 400_000_000 / UInt64(n)
    
    Task {
      do {
        for card in [topCardIndex..<cardSet.setOfCards.count, 0..<topCardIndex].joined() {
          if cardSet.setOfCards[card].flipped == (direction == .up)  {
            cardSet.setOfCards[card].flipped.toggle()
            try await Task.sleep(nanoseconds: nanoSec)
          }
        }
      } catch {
      }
    }
  }
  enum Direction {
    case up
    case down
  }

  @ViewBuilder
  private func cardView(_ card: Card) -> some View {
    let index = cardSet.index(card: card)
    let visualIndex = (index - topCardIndex + len) % len
    let progress = min(abs(dragOffset.width) / 150, 1)
    let signedProgress = (dragOffset.width >= 0 ? 1 : -1) * progress

    FlipCardView(card: card)
      .frame(width: width, height: 175)
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
    visualIndex == 0 ? 0 : (Double(visualIndex) - progress) * 15.0 * shiftFactor
  }

  private func scaleFor(visualIndex: Int, progress: Double) -> CGFloat {
    switch visualIndex {
    case 0:
      return 1
    case 1:
      return 1.0 - (Double(visualIndex) + progress) * 0.06
    default:
      return 1.0 - Double(visualIndex) * 0.06 * (shiftFactor + 0.3)
    }
  }

  private func offsetXBackFor(visualIndex: Int) -> CGFloat {
    visualIndex == 0 ? 0 : Double(visualIndex) * 10 * shiftFactor
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
        dragOffset.width = direction < 0 ? -width * 1.15 : width
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
    name: "Местоимения", setOfCards: [
      Card(word: "Cat", translation: "Кот"), 
      Card(word: "Dog", translation: "Собака"),
      Card(word: "Mouse", translation: "Мышь"),
      Card(word: "Bat", translation: "Летучая мышь"),
      Card(word: "Snake", translation: "Змея")
      ,
      Card(word: "Cat", translation: "Кот"), 
      Card(word: "Dog", translation: "Собака"),
      Card(word: "Mouse", translation: "Мышь"),
      Card(word: "Bat", translation: "Летучая мышь"),
      Card(word: "Snake", translation: "Змея"),
      Card(word: "Cat", translation: "Кот"), 
      Card(word: "Dog", translation: "Собака"),
      Card(word: "Mouse", translation: "Мышь"),
      Card(word: "Bat", translation: "Летучая мышь"),
      Card(word: "Snake", translation: "Змея"),
      Card(word: "Cat", translation: "Кот"), 
      Card(word: "Dog", translation: "Собака"),
      Card(word: "Mouse", translation: "Мышь"),
      Card(word: "Bat", translation: "Летучая мышь"),
      Card(word: "Snake", translation: "Змея")
    ]
  )
  StackView(cardSet: $stack)
    .environmentObject(DataLangs())
}
