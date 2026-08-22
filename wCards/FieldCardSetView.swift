//
//  WordInListView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct FieldInListView: View {
  @EnvironmentObject var allLangs: AllLanguages
  @State var cardSet: CardSet
  
  var body: some View {
    HStack {
      TextField("Category", text: $cardSet.name)
    }
    
  }
}

#Preview {
  @Previewable @State var cardSet = CardSet()
  FieldInListView(cardSet: cardSet)
}
