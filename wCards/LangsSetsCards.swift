//
//  ContentView.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import SwiftUI

struct LangsSetsCards: View {
  @EnvironmentObject var allLangs: AllLanguages
  @State private var cardSet: CardSet = CardSet()
  @State private var showStack: Bool = false
  var body: some View {
    
    ZStack {
      NavigationSplitView { 
        VStack {
          List(selection: $allLangs.langID) {
            ForEach(allLangs.langs, id: \.id) { lang in
              Text(lang.name)
            }
            .onDelete(perform: deleteLangs)
            .onMove { indices, newOffset in
              moveLang(from: indices, to: newOffset)
            }
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
        if let language = allLangs.lang(ID: allLangs.langID) {
          List(selection: $allLangs.setID) {
            ForEach(language.sets, id: \.id) { set in
              Text(set.name)
            }
            .onDelete(perform: deleteSets)
            .onMove { indices, newOffset in
              moveSet(from: indices, to: newOffset)
            }
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
              }
              .buttonStyle(.glassProminent)
            }
          }
        } else {
          Text("Select a Language")
        }
      } detail: {
        if let language = allLangs.lang(ID: allLangs.langID) {
          if let set = language.set(ID: allLangs.setID) {
            List {
              ForEach(set.setOfCards, id: \.id) { card in
                WordInListView(card: card)
              }
              .onDelete(perform: deleteCards)
              .onMove(perform: moveCard)
            }
            .toolbar {
              
              ToolbarSpacer(.flexible, placement: .bottomBar)
              ToolbarItem(placement: .bottomBar) {
                
                Button {
                  cardSet = set
                  showStack.toggle()
                } label: {
                  Image(systemName: "play.square.stack")
                }
                .buttonStyle(.glassProminent)
                
              }
              
              ToolbarItem(placement: .bottomBar) {
                Button(action: {
                  set.newCard()
                  print("=> 3")
                }) {
                  Image(systemName: "plus")
                }
              }
            }
            .navigationTitle(titleSet())
          }
          
        } else {
          Text("Select a Set of words")
        }
      }
      
    }
    .animation(.easeInOut(duration: 0.3), value: showStack)
    .sheet(isPresented: $showStack) { 
      StackView(cardSet: $cardSet)
    }
    
  }
  
  private func deleteLangs(at offsets: IndexSet) {
    allLangs.langs.remove(atOffsets: offsets)
  }
  
  private func moveLang(from source: IndexSet, to destination: Int) {
    print("move executed")
    allLangs.langs.move(fromOffsets: source, toOffset: destination)
  }
  
  private func deleteSets(at offsets: IndexSet) {
    if let language = allLangs.lang(ID: allLangs.langID) {
      language.sets.remove(atOffsets: offsets)
    }
  }
  
  private func moveSet(from source: IndexSet, to destination: Int) {
    print("move executed")
    allLangs.lang(ID: allLangs.langID!)!.sets.move(fromOffsets: source, toOffset: destination)
  }
  
  private func deleteCards(at offsets: IndexSet) {
    if let language = allLangs.lang(ID: allLangs.langID) {
      if let set = language.set(ID: allLangs.setID) {
        set.setOfCards.remove(atOffsets: offsets)
      }
    }
  }
  
  private func moveCard(from source: IndexSet, to destination: Int) {
    print("move executed")
    allLangs.lang(ID: allLangs.langID!)!.set(ID: allLangs.setID!)!.setOfCards.move(fromOffsets: source, toOffset: destination)
  }
  
  private func titleSet() -> String {
    let langName: String = allLangs.lang(ID: allLangs.langID!)!.name
    let noLangName: Bool = langName == ""
    
    let setName: String = allLangs.lang(ID: allLangs.langID!)!.set(ID: allLangs.setID!)!.name
    let noSetName: Bool = setName == ""
    
    return "\(noLangName ? "some lang." : langName) | \(noSetName ? "some set" : setName)"
  }
  
  private func titleLang() -> String {
    let langName: String = allLangs.lang(ID: allLangs.langID!)!.name
    let noLangName: Bool = langName == ""
    
    return "\(noLangName ? "some lang." : langName)"
  }
  
}

#Preview("Main") {
    LangsSetsCards()
    .environmentObject(AllLanguages())
}
