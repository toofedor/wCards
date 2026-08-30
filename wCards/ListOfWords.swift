//
//  ListOfWords.swift
//  wCards
//
//  Created by Fedor Komov on 27.08.2026.
//

import SwiftUI

struct ListOfWords: View {
  @EnvironmentObject var dataLangs: DataLangs
  @State var set: CardSet
  @State private var cardSet: CardSet = CardSet()
  @State private var showStack: Bool = false
    var body: some View {
      List {
        ForEach(set.setOfCards, id: \.id) { card in
          WordInListView(card: card)
        }
        .onDelete(perform: deleteCards)
              .onMove(perform: moveCard)
      }
    }
  
  private func deleteCards(at offsets: IndexSet) {
    if let language = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID) {
      if let set = language.findSet(ID: dataLangs.allLangs.setID) {
        set.setOfCards.remove(atOffsets: offsets)
      }
    }
  }
  
  private func moveCard(from source: IndexSet, to destination: Int) {
    dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.findSet(ID: dataLangs.allLangs.setID!)!.setOfCards.move(fromOffsets: source, toOffset: destination)
  }
}

