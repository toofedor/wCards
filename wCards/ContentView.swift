//
//  ContentView.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import SwiftUI

struct ContentView: View {
  @State var allLangs: AllLanguages = AllLanguages()
  @State var langID: Language.ID?
  @State var setID: CardsSet.ID?
  @State var wordID: Card.ID?
  var body: some View {
    
    NavigationSplitView { 
      VStack {
        List(selection: $langID) { 
          ForEach(allLangs.langs, id: \.id){ lang in
            Text(lang.name)
          }
          .onDelete(perform: deleteLangs)
        }
      }
      .navigationTitle("Laguages")
      .toolbar {
        ToolbarSpacer(.flexible, placement: .bottomBar)
        ToolbarItem(placement: .bottomBar) {
          
          Button(action: {
            allLangs.newLang()
            print("=> 1")
          }) {
            Image(systemName: "plus")
          }
          .buttonStyle(.glassProminent)
        }
      }
    } content: {
      if let language = allLangs.lang(ID: langID) {
        List(selection: $setID) {
          ForEach(language.sets, id: \.id) { set in
            Text(set.name)
          }
          .onDelete(perform: deleteSets)
        }
        .navigationTitle(titleLang())
        .toolbar {
          ToolbarSpacer(.flexible, placement: .bottomBar)
          ToolbarItem(placement: .bottomBar) {
            
            Button(action: {
              language.newSet()
              print("=> 2")
            }) {
              Image(systemName: "plus")
            }.buttonStyle(.glassProminent)
          }
        }
      } else {
        Text("Select a Language")
      }
    } detail: { 
      if let language = allLangs.lang(ID: langID) {
      if let set = language.set(ID: setID) {
        List(selection: $wordID){
          ForEach(set.setOfCards, id: \.id) { card in
            Text(card.word)
            
          } 
          .onDelete(perform: deleteCards)
        }
        .toolbar {
          ToolbarSpacer(.flexible, placement: .bottomBar)
          ToolbarItem(placement: .bottomBar) {
            
            Button(action: {
              set.newCard()
              print("=> 3")
            }) {
              Image(systemName: "plus")
            }
            .buttonStyle(.glassProminent)
          }
        }
        .navigationTitle(titleSet())
        }
        
      } else {
        Text("Select a Set of words")
      }
    }
  
  }

  private func deleteLangs(at offsets: IndexSet) {
    allLangs.langs.remove(atOffsets: offsets)
  }

  private func deleteSets(at offsets: IndexSet) {
    if let language = allLangs.lang(ID: langID) {
      language.sets.remove(atOffsets: offsets)
    }
  }  

  private func deleteCards(at offsets: IndexSet) {
    if let language = allLangs.lang(ID: langID) {
      if let set = language.set(ID: setID) {
        set.setOfCards.remove(atOffsets: offsets)
      }
    }
  }
  
  private func titleSet() -> String {
    let langName: String = allLangs.lang(ID: langID!)!.name
    let noLangName: Bool = langName == ""
    
    let setName: String = allLangs.lang(ID: langID!)!.set(ID: setID!)!.name
    let noSetName: Bool = setName == ""
    
    return "\(noLangName ? "some lang." : langName) | \(noSetName ? "some set" : setName)"
  }
  
  private func titleLang() -> String {
    let langName: String = allLangs.lang(ID: langID!)!.name
    let noLangName: Bool = langName == ""
    
    return "\(noLangName ? "some lang." : langName)"
  }
}

#Preview {
    ContentView()
}
