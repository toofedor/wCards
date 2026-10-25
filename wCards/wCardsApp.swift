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
  @StateObject var splitCopy: CopySplitManager = CopySplitManager()
  
  var body: some Scene {
    WindowGroup {
      SplitScreens()
    }
    .environmentObject(dataLangs)
    .environmentObject(splitCopy)
  }
}
