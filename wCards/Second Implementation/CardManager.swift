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
  
  func flipCard() {
    withAnimation { 
      isFlipped.toggle()
      isBackSideShown.toggle()
      rotationAngle += 180
    }
  }
}
