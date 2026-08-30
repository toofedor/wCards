//
//  WordInListView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct FieldCardSetInListView: View {
  @EnvironmentObject var dataLangs: DataLangs
  
  @State var cardSet: CardSet
  
  var body: some View {
    HStack {
      TextField("Category", text: $cardSet.name)
    }
    .onChange(of: cardSet.name) { 
      dataLangs.saveTrigger()
    }
    
  }
}

struct FieldLanguageInListView: View {
  @EnvironmentObject var dataLangs: DataLangs
  
  @State var language: Language
  
  var body: some View {
    HStack {
      TextField("Category", text: $language.name)
    }
    .onChange(of: language.name) { 
      dataLangs.saveTrigger()
    }
    
  }
}

#Preview {
  @Previewable @State var cardSet = CardSet()
  FieldCardSetInListView(cardSet: cardSet)
}
