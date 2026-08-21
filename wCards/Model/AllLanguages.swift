//
//  AllSets.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation
import Observation
import SwiftUI
import Combine

@Observable class AllLanguages: ObservableObject, Identifiable, Codable, CustomStringConvertible {
  var name: String
  var langs: [Language]
  var id: UUID
  
  var langID: Language.ID?
  var setID: CardSet.ID?
  var wordID: Card.ID?
  
  init(name: String = "", langs: [Language] = [Language(name: "English")], id: UUID = UUID()) {
    self.name = name
    self.id = id
    self.langs = langs
  }
  
  func newLang() {
    langs.append(Language(name: "\(langs.count)"))
  }
  
  func lang(ID: UUID?) -> Language? {
    print("lang(ID = \(ID?.uuidString ?? "nil")")
    let lang = langs.first(where: {$0.id == ID})
    print(lang?.description ?? "no lang found")
    return langs.first(where: {$0.id == ID})
  }  

  var description: String {
    "AllLanguages \"\(name)\" with \(langs.count) set\(langs.count == 1 ? "" : "s")"
  }
  
  static func == (lhs: AllLanguages, rhs: AllLanguages) -> Bool {
    lhs.id == rhs.id
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
  
}
