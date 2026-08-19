//
//  Cards.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation
import Observation
import SwiftUI
import Combine

@Observable class CardsSet: ObservableObject, Identifiable, Codable, CustomStringConvertible, Comparable, Equatable {
  var name: String
  var langID: Language.ID
  var setOfCards: [Card]
  var id: UUID
  
  var learnt: Bool {
    return setOfCards.allSatisfy { $0.progressStatus.rawValue > 2 }
  }
  
  init(name: String = "Greetings", langID: Language.ID = UUID(), setOfCards: [Card] = [Card()], id: UUID = UUID()) {
    self.name = name
    self.langID = langID
    self.id = id
    self.setOfCards = setOfCards
  }
  
  func card(ID: UUID?) -> Card? {
    return setOfCards.first(where: {$0.id == ID})
  }
  
  func newCard() {
    setOfCards.append(Card(word: "", setID: self.id))
  }
  
  
  
  var description: String {
    "Set Of Cards \"\(name)\" with \(setOfCards.count) word\(setOfCards.count == 1 ? "" : "s")"
  }
  
  static func < (lhs: CardsSet, rhs: CardsSet) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: CardsSet, rhs: CardsSet) -> Bool {
    guard lhs.setOfCards.count == rhs.setOfCards.count else { return false }
    let lCards = lhs.setOfCards.sorted()
    let rCards = lhs.setOfCards.sorted()
    for n in lCards.indices {
      guard lCards[n] == rCards[n] else { return false }
    }
    return true
  }
}
