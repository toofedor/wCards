//
//  Card.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation
import Observation
import SwiftUI
import Combine

@Observable class Card: ObservableObject, Identifiable, Codable, CustomStringConvertible, Comparable, Equatable, Hashable, Sendable {
  
  var languageStuding: String
  var languageNative: String
  var setID: CardSet.ID
  var word: String
  var translation: String
  var progressForward: Double
  var progressBackward: Double
  var progressStatus: ProgressStatus
  var flipped: Bool = false
  var id: UUID
  
  init(languageStuding: String = "English",
       languageNative: String = "Russian",
       word: String = "Hellow",
       translation: String = "Привет",
       setID: CardSet.ID = UUID(),
       progressForward: Double = 0,
       progressBackward: Double = 0,
       progressStatus: ProgressStatus = .unknown,
       id: UUID = UUID()
  ) {
    self.setID = setID
    self.languageStuding = languageStuding
    self.languageNative = languageNative
    self.word = word
    self.translation = translation
    self.progressForward = progressForward
    self.progressBackward = progressBackward
    self.progressStatus = progressStatus
    self.id = id
  }
  
  var description: String {
    "\(word) / \(translation)"
  }
  
  static func < (lhs: Card, rhs: Card) -> Bool {
    lhs.languageStuding < rhs.languageStuding
  }
  
  static func == (lhs: Card, rhs: Card) -> Bool {
    lhs.languageStuding == rhs.languageStuding && lhs.languageNative == rhs.languageNative
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

enum ProgressStatus: Int, Codable {
  case unknown
  case familiar
  case known
  case learned
  
  var str: String {
    switch self {
    case .unknown: return "Unknown"
    case .familiar: return "Familiar"
    case .known: return "Known"
    case .learned: return "Learned"
    }
  }
}
