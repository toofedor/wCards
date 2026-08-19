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

@Observable class Card: ObservableObject, Identifiable, Codable, CustomStringConvertible, Comparable, Equatable {
  
  var languageStuding: String
  var languageNative: String
  var setID: CardsSet.ID
  var word: String
  var translation: String
  var progressForward: Double
  var progressBackward: Double
  var progressStatus: ProgressStatus
  var id: UUID
  
  init(languageStuding: String = "English", languageNative: String = "Russian", word: String = "Hellow", translation: String = "Привет", setID: CardsSet.ID = UUID(), progressForward: Double = 0, progressBackward: Double = 0, progressStatus: ProgressStatus = .unknown, id: UUID = UUID()) {
    self.id = id
    self.setID = setID
    self.languageStuding = languageStuding
    self.languageNative = languageNative
    self.word = word
    self.translation = translation
    self.progressForward = progressForward
    self.progressBackward = progressBackward
    self.progressStatus = progressStatus
  }
  
  
  var description: String {
    "\(languageStuding) / \(languageNative)"
  }
  
  static func < (lhs: Card, rhs: Card) -> Bool {
    lhs.languageStuding < rhs.languageStuding
  }
  
  static func == (lhs: Card, rhs: Card) -> Bool {
    lhs.languageStuding == rhs.languageStuding && lhs.languageNative == rhs.languageNative
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
