//
//  Language.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation
import Observation
import SwiftUI
import Combine

@Observable class Language: ObservableObject, Identifiable, Codable, CustomStringConvertible, Equatable, Hashable, Sendable {
  var name: String
  var sets: [CardSet]
  var id: UUID
  
  init(name: String, sets: [CardSet] = [CardSet()], id: UUID = UUID()) {
    self.name = name
    self.id = id
    self.sets = sets
//    print(description)
  }
  
  func findSet(ID: UUID?) -> CardSet? {
    return sets.first(where: {$0.id == ID})
  }
  
  func setInd(ID: UUID?) -> Int {
    return sets.firstIndex(where: {$0.id == ID}) ?? 0
  }
  
  func newSet(_ n: Int = 1) {
    let setOfCards = CardSet(name: "", langID: self.id, setOfCards: [])
    setOfCards.newCard(n)
    sets.append(setOfCards)
  }
  
  var description: String {
    "Lang \"\(name)\" with \(sets.count) set\(sets.count == 1 ? "" : "s") \(id.uuidString)"
  }
  
  static func == (lhs: Language, rhs: Language) -> Bool {
    guard lhs.sets.count == rhs.sets.count else { return false }
    let lSets = lhs.sets.sorted()
    let rSets = lhs.sets.sorted()
    for n in lSets.indices {
      guard lSets[n] == rSets[n] else { return false }
    }
    return true
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
