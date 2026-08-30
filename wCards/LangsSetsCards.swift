//
//  ContentView.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import Foundation
import SwiftUI

struct LangsSetsCards: View {
  @EnvironmentObject var dataLangs: DataLangs
  @State private var cardSet: CardSet = CardSet()
  @State private var showStack: Bool = false
  @State private var changingSet: Bool = false
  @State private var changingLang: Bool = false
  @State private var toggleList: Bool = false
  @State var cardBuffer: [Card] = []
  @State var setCutFrom: CardSet?
  var body: some View {
    
    ZStack {
      NavigationSplitView { 
        VStack {
          List(selection: $dataLangs.allLangs.langID) {
            ForEach(dataLangs.allLangs.langs, id: \.id) { lang in
              if changingLang {
                FieldLanguageInListView(language: lang)
              } else {
                Text(lang.name)
              }
            }
            .onDelete(perform: deleteLangs)
            .onMove { indices, newOffset in
              moveLang(from: indices, to: newOffset)
            }
          }
          .onChange(of: dataLangs.allLangs.langID) {
            changingSet = false
            changingLang = false
          }
        }
        .navigationTitle("Laguages")
        .toolbar {
          ToolbarSpacer(.flexible, placement: .bottomBar)
          ToolbarItem(placement: .bottomBar) {
            
            EditBtn(value: $changingLang)
              .buttonStyle(.glassProminent)
              
          }
          ToolbarItem(placement: .bottomBar) {
            
            Button(action: {
              dataLangs.allLangs.newLang()
              changingLang = true
//              print("=> 1")
            }) {
              Image(systemName: "plus")
            }
          }
        }
      } content: {
        if let language = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID) {
          List(selection: $dataLangs.allLangs.setID) {
            ForEach(language.sets, id: \.id) { set in
              HStack {
                if changingSet {
                  FieldCardSetInListView(cardSet: set)
                } else {
                  Text(set.name)
                  fourWords(set)
                }
                Spacer()
                Text("\(set.setOfCards.count)")
                  .opacity(0.3)
              }
            }
            .onDelete(perform: deleteSets)
            .onMove { indices, newOffset in
              moveSet(from: indices, to: newOffset)
            }
          }
          .onChange(of: dataLangs.allLangs.langID) {
            changingSet = false
            changingLang = false
          }
          .navigationTitle(titleLang())
          .toolbar {
            ToolbarSpacer(.flexible, placement: .bottomBar)
            ToolbarItem(placement: .bottomBar) {
                EditBtn(value: $changingSet)
            }
            
            ToolbarItem(placement: .bottomBar) {
              Menu {
                Button {
                  language.newSet(10)
                  changingSet = true
                  
              } label: {
                  Image(systemName: "rectangle.stack")
                  Text("Set with 10 cards")
              }
                
                Button {
                  language.newSet(1)
                  changingSet = true
                  
              } label: {
                  Image(systemName: "rectangle")
                  Text("Set with one card")
              }
                
                Button {
                  language.newSet(0)
                  changingSet = true
                  
                } label: {
                    Image(systemName: "rectangle.dashed")
                    Text("Empty set of cards")
                }
              } label: {
                Image(systemName: "plus")
              } primaryAction: {
                language.newSet(5)
                changingSet = true}
              .onTapGesture {
                language.newSet(5)
                changingSet = true
              }
            }
            
          }
        } else {
          Text("Select a Language")
        }
      } detail: {
        if let language = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID) {
          if let set = language.findSet(ID: dataLangs.allLangs.setID) {
            ZStack {
              if toggleList {
                ListOfWords(set: set)
              } else {
                ListOfWords(set: set)
              }
            }
            .toolbar {
              
              ToolbarSpacer(.flexible, placement: .bottomBar)
              
              
              ToolbarItem(placement: .bottomBar) {
                
                Menu {
                  
                  Button {
                    set.setOfCards.forEach { $0.pointed = Bool.random() }
                  } label: {
                    HStack {
                      Text("Check random")
                      Image(systemName: "dice")
                    }
                  }
                  
                  Button {
                    set.setOfCards.forEach { $0.pointed.toggle() }
                  } label: {
                    Image(systemName: "arrow.left.arrow.right").rotationEffect(.degrees(90))
                    Text("Invrse selection")
                  }
                  .buttonStyle(.glassProminent)
                  .onLongPressGesture {
                    set.setOfCards.forEach { $0.pointed.toggle() }
                  }
                  
                  
                  Button {
                    set.setOfCards.forEach { $0.pointed = false }
                  } label: {
                    HStack {
                      Text("Check all")
                      Image(systemName: "checkmark.rectangle.fill")
                    }
                  }
                  
                  
                  Button {
                    set.setOfCards.forEach { $0.pointed = false }
                  } label: {
                    HStack {
                      Text("Uncheck all")
                      Image(systemName: "checkmark.rectangle")
                    }
                  }
                  
                } label: {
                  ZStack {
                    Image(systemName: "checkmark.rectangle.stack")
                      .offset(x: -3, y: 3)
                    Text("\(set.setOfCards.count { $0.pointed == true })")
                      .font(.system(.caption2, design: .default, weight: .bold))
                      .offset(x: 11, y: -11)
                  }
                } primaryAction: {
                  cardSet = set.filtCards()
                  showStack.toggle()}
                .onTapGesture {
                  cardSet = set.filtCards()
                  showStack.toggle()
                }
              }
              
              
              ToolbarItem(placement: .bottomBar) {
                Button {
                  cardSet = set
                  showStack.toggle()
                } label: {
                  Image(systemName: "rectangle.stack")
                }
                .buttonStyle(.glassProminent)
              }
              
              ToolbarItem(placement: .bottomBar) {
                Button {
                  set.setOfCards.shuffle()
                  toggleList.toggle()
                } label: {
                  Image(systemName: "shuffle")
                }
              }
              
              ToolbarItem(placement: .bottomBar) {
                Menu {
                  Button {
                  set.setOfCards.sort(by: { $0.word < $1.word })
                  toggleList.toggle()
                } label: {
                  ZStack {
                    Image(systemName: "arrow.up.and.down")
                      .offset(x: -5)
                    Text("Sort by learning words")
                      .font(.system(.callout, design: .default, weight: .semibold))
                      .offset(x: 9)
                  }
                }
                  
                  Button {
                    set.setOfCards.sort(by: { $0.translation < $1.translation })
                    toggleList.toggle()
                  } label: {
                    ZStack {
                      Image(systemName: "arrow.up.and.down")
                        .offset(x: -5)
                      Text("Sort by translation")
                        .kerning(-0.3)
                        .font(.system(.callout, design: .default, weight: .semibold))
                        .offset(x: 9)
                    }
                  }
                } label: {
                  Image(systemName: "arrow.up.and.down")
                } primaryAction: {
                  set.setOfCards.sort(by: { $0.word < $1.word })
                  toggleList.toggle()}
                .onTapGesture {
                  set.setOfCards.sort(by: { $0.word < $1.word })
                  toggleList.toggle()
                }
              }
              
              ToolbarItem(placement: .bottomBar) {
                Menu {
                  Button {
                    cardBuffer = set.setOfCards.filter { $0.pointed == true }
                    setCutFrom = set
                  } label: {
                    Image(systemName: "tray.and.arrow.up")
                    Text("Cut from the list")
                  }
                  
                  
                  Button {
                    cardBuffer = set.setOfCards.filter { $0.pointed == true }
                  } label: {
                    Image(systemName: "rectangle.on.rectangle.dashed")
                    Text("Copy to a list")
                  }
                  
                  Button {
                    
                    cardBuffer.forEach {
                      if let setCutFrom {
                        setCutFrom.removeCard($0)
                      }
                      $0.id = UUID()
                      $0.setID = set.id
                      set.copyCard($0)
                    }
                    setCutFrom = nil
                    
                    dataLangs.saveTrigger()
                  } label: {
                    Image(systemName: "tray.and.arrow.down")
                    Text("Paste to the list")
                  }
                  
                  Button {
                    
                    set.setOfCards.removeAll { $0.pointed }
                    
                    dataLangs.saveTrigger()
                  } label: {
                    Image(systemName: "trash")
                    Text("Delete selected")
                  }
                  
                } label: {
                    Image(systemName: "ellipsis")
                }
              }
              
              ToolbarItem(placement: .bottomBar) {
                Menu {
                  Button(action: {
                    set.newCard()
                  }) {
                    Image(systemName: "plus")
                    Text("1 word")
                  }
                  
                  Button(action: {
                    set.newCard(5)
                  }) {
                    Image(systemName: "plus")
                    Text("5 words")
                  }
                  
                  Button(action: {
                    set.newCard(10)
                  }) {
                    Image(systemName: "plus")
                    Text("10 words")
                  }
                  Label("Menu", systemImage: "gear")
                } label: {
                  Image(systemName: "plus")
                } primaryAction: {
                  set.newCard()}
                .onTapGesture {
                  set.newCard()
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
  
  
  @ViewBuilder
  private func fourWords(_ cardSet: CardSet) -> some View {
    let len = cardSet.setOfCards.count
    let n = cardSet.countWords()
    let dotsShow: Bool = len > n
    HStack {
      ForEach(0..<n, id: \.self) { ind in
        Text(cardSet.setOfCards[ind].word)
          .opacity(0.3)
          .font(.caption)
      }
      
      if dotsShow {
        HStack(spacing: 3) {
          ForEach(0..<3) { _ in
            Circle()
              .frame(width: 3, height: 3)
              .opacity(0.3)
          }
        }
      }
    }
  }
  
  private func deleteLangs(at offsets: IndexSet) {
    dataLangs.allLangs.langs.remove(atOffsets: offsets)
  }
  
  private func moveLang(from source: IndexSet, to destination: Int) {
//    print("move executed")
    dataLangs.allLangs.langs.move(fromOffsets: source, toOffset: destination)
  }
  
  private func deleteSets(at offsets: IndexSet) {
    if let language = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID) {
      language.sets.remove(atOffsets: offsets)
    }
  }
  
  private func moveSet(from source: IndexSet, to destination: Int) {
//    print("move executed")
    dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.sets.move(fromOffsets: source, toOffset: destination)
  }
  
  private func deleteCards(at offsets: IndexSet) {
    if let language = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID) {
      if let set = language.findSet(ID: dataLangs.allLangs.setID) {
        set.setOfCards.remove(atOffsets: offsets)
      }
    }
  }
  
  private func moveCard(from source: IndexSet, to destination: Int) {
//    print("move executed")
    dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.findSet(ID: dataLangs.allLangs.setID!)!.setOfCards.move(fromOffsets: source, toOffset: destination)
  }
  
  private func titleSet() -> String {
    let langName: String = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.name
    let noLangName: Bool = langName == ""
    
    let setName: String = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.findSet(ID: dataLangs.allLangs.setID!)!.name
    let noSetName: Bool = setName == ""
    
    return "\(noLangName ? "some lang." : langName) | \(noSetName ? "some set" : setName)"
  }
  
  private func titleLang() -> String {
    let langName: String = dataLangs.allLangs.lang(ID: dataLangs.allLangs.langID!)!.name
    let noLangName: Bool = langName == ""
    return "\(noLangName ? "some lang." : langName)"
  }
  
}



#Preview("Main") {
  @Previewable @StateObject var dataLangs = DataLangs()
    LangsSetsCards()
    .environmentObject(dataLangs)
}
