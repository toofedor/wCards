//
//  WordInListView.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct WordInListView: View {
  @EnvironmentObject var dataLangs: DataLangs
  @State var card: Card
  
  var body: some View {
    HStack(spacing: 8) {
      TextField("Word", text: $card.word)
      TextField("Translation", text: $card.translation)
      MyToggle(isOn: $card.pointed)
      .frame(width: 25, height: 19)
    }
    .onChange(of: card.word) {
      dataLangs.saveTrigger()
    }
    .onChange(of: card.translation) {
      dataLangs.saveTrigger()
    }
    .onChange(of: card.pointed) {
      dataLangs.saveTrigger()
    }
    
  }
}

struct MyToggle: View {
  @Binding var isOn: Bool
  var body: some View {
    
      HStack {
        if isOn {
          Image(systemName: "checkmark.rectangle.fill")
            .resizable()
            .foregroundStyle(Color.accentColor)
          
        } else {
          Image(systemName: "checkmark.rectangle")
            .resizable()
            .foregroundStyle(.gray.opacity(0.8))
        }
      }
      .frame(width: 25, height: 19)
      .onTapGesture {
        isOn.toggle()
      }
    
      .contentShape(Rectangle())
  }
}

#Preview {
  @Previewable @State var card = Card(word: "12341234123412341234", translation: "567895678567856785678")
  @Previewable @StateObject var dataLangs = DataLangs()
  WordInListView(card: card)
    .environmentObject(dataLangs)
}
