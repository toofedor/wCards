//
//  AllSets.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation

class AllLanguages: Identifiable, Codable, CustomStringConvertible {
  var name: String
  var langs: [Language]
  var id: UUID
  
  init(name: String = "", langs: [Language] = [Language(name: "English")], id: UUID = UUID()) {
    self.name = name
    self.id = id
    self.langs = langs
  }
  
  var description: String {
    "AllLanguages \"\(name)\" with \(langs.count) set\(langs.count == 1 ? "" : "s")"
  }
  
  func lang(ID: UUID?) -> Language? {
    print("lang(ID = \(ID?.uuidString ?? "nil")")
    let lang = langs.first(where: {$0.id == ID})
    print(lang?.description ?? "no lang found")
    return langs.first(where: {$0.id == ID})
  }
}
