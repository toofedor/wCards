//
//  Language.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation

class Language: Identifiable, Codable, CustomStringConvertible {
  var name: String
  var sets: [CardsSet]
  var id: UUID
  
  init(name: String, sets: [CardsSet] = [CardsSet()], id: UUID = UUID()) {
    self.name = name
    self.id = id
    self.sets = sets
    print(description)
  }
  
  func set(ID: UUID?) -> CardsSet? {
    return sets.first(where: {$0.id == ID})
  }
  
  var description: String {
    "Lang \"\(name)\" with \(sets.count) set\(sets.count == 1 ? "" : "s") \(id.uuidString)"
  }
}
