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

@Observable class CardSet: ObservableObject, Identifiable, Codable, CustomStringConvertible, Comparable, Equatable, Hashable, Sendable {
  var name: String
  var langID: Language.ID
  var setOfCards: [Card]
  var id: UUID
  
  var learnt: Bool {
    return setOfCards.allSatisfy { $0.progressStatus.rawValue > 2 }
  }
  
  init(name: String = "Set of words", langID: Language.ID = UUID(), setOfCards: [Card] = [Card(), Card(), Card(), Card(), Card(), Card(), Card(), Card(), Card(), Card()], id: UUID = UUID()) {
    self.name = name
    self.langID = langID
    self.id = id
    self.setOfCards = setOfCards
  }
  
  func card(ID: UUID?) -> Card? {
    return self.setOfCards.first(where: {$0.id == ID})
  }
  
  func index(card: Card) -> Int {
    return self.setOfCards.firstIndex(where: {$0.id == card.id}) ?? 0
  }
  
  func removeCard(_ card: Card) {
    self.setOfCards.removeAll { $0.id == card.id }
  }
  
  func newCard(_ n: Int = 1) {
    guard n > 0 else { return }
    for _ in 0..<n {
      self.setOfCards.append(Card(word: "", translation: "", setID: self.id))
    }
  }
  func copyCard(_ card: Card) {
    self.setOfCards.append(Card(languageStuding: card.languageStuding,
                                languageNative: card.languageNative,
                                word: card.word,
                                translation: card.translation,
                                setID: card.setID,
                                progressForward: card.progressForward,
                                progressBackward: card.progressBackward,
                                progressStatus: card.progressStatus,
                                pointed: card.pointed,
                                id: card.id
                               )
    )
  }
  
  func filtCards() -> CardSet {
    return CardSet(name: self.name, setOfCards: self.setOfCards.filter({ $0.pointed == true }))
  }
  
  
  // добавить в Анд
  func countWords() -> Int {
    var n = 0
    var len = Int(Double(self.name.count) * 1.5)
    for card in self.setOfCards {
      len += card.word.count
      n += 1
      if len > 35 || n >= 4 { break }
    }
    return n
  }
  
  var description: String {
    "Set Of Cards \"\(name)\" with \(setOfCards.count) word\(setOfCards.count == 1 ? "" : "s")"
  }
  
  static func < (lhs: CardSet, rhs: CardSet) -> Bool {
    lhs.name < rhs.name
  }
  
  static func == (lhs: CardSet, rhs: CardSet) -> Bool {
    guard lhs.setOfCards.count == rhs.setOfCards.count else { return false }
    let lCards = lhs.setOfCards.sorted()
    let rCards = lhs.setOfCards.sorted()
    for n in lCards.indices {
      guard lCards[n] == rCards[n] else { return false }
    }
    return true
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
