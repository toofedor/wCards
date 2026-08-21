//
//  WordInListView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct WordInListView: View {
  @EnvironmentObject var allLangs: AllLanguages
  @State var card: Card
  
  var body: some View {
    HStack {
      TextField("Word", text: $card.word)
      TextField("Translation", text: $card.translation)
    }
    
  }
}

#Preview {
  @Previewable @State var card = Card(word: "1234", translation: "56789")
  WordInListView(card: card)
}
