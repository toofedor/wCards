//
//  Cards.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation

class CardsSet: Identifiable, Codable, CustomStringConvertible, Comparable, Equatable {
  var name: String
  var setOfCards: [Card]
  var id: UUID
  
  var learnt: Bool {
    return setOfCards.allSatisfy { $0.progressStatus.rawValue > 2 }
  }
  
  init(name: String = "English greetings", setOfCards: [Card] = [Card()], id: UUID = UUID()) {
    self.name = name
    self.id = id
    self.setOfCards = setOfCards
  }
  
  func card(ID: UUID?) -> Card? {
    return setOfCards.first(where: {$0.id == ID})
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
