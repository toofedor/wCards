//
//  CardManager.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI
import Combine

class CardManager: ObservableObject {
  
  @Published var isFlipped: Bool = false
  @Published var isBackSideShown: Bool = false
  @Published var rotationAngle: Double = 0
  let duration: Double = 0.5
  func flipCardBouncy() {
    withAnimation(.bouncy(duration: duration)) { 
      isFlipped.toggle()
      rotationAngle += 180
    }
    Task {
      try? await Task.sleep(for: .seconds(duration / 4.6))
      isBackSideShown.toggle()
    }
  }
}
