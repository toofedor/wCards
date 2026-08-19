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
  var body: some View {
    
    NavigationSplitView { 
      List(allLangs.langs, selection: $langID) { lang in
        Text(lang.name)
      }
    } content: {
      if let language = allLangs.lang(ID: langID) {
        List(language.sets, selection: $setID) { set in
          Text(set.name)
        }
      } else {
        Text("Select a Language")
      }
    } detail: { 
      Text("")
    }
  
  }
}

#Preview {
    ContentView()
}
