//
//  wCardsApp.swift
//  wCards
//
//  Created by Fedor Komov on 19.08.2026.
//

import SwiftUI

@main
struct wCardsApp: App {
  @StateObject var dataLangs: DataLangs = DataLangs()
  var body: some Scene {
    WindowGroup {
      LangsSetsCards()
    }
    .environmentObject(dataLangs)
  }
}
