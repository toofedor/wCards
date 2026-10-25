//
//  AllSets.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Observation
import Combine

@Observable class CopySplitManager: ObservableObject {
  
  var showSplit: Bool = false
  var cardBuffer: [Card] = []
  var setCutFrom: CardSet?
  
  var langID: Language.ID?
  var setID: CardSet.ID?
}
