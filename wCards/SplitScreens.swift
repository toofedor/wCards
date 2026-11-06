//
//  ContentView.swift
//  SplitScreenApp
//
//  Created by Fedor Komov on 23.10.2026.
//

import SwiftUI

struct SplitScreens: View {
  @EnvironmentObject var dataLangs: DataLangs
  @EnvironmentObject var splitCopy: CopySplitManager
  @Environment(\.colorScheme) private var colorScheme
  let screenHeight = UIScreen.main.bounds.height
  @State private var dragOffset: CGSize = .zero
  @State var bannerPositionY: Double = 400
  
  var body: some View {
    VStack(spacing: 0) {
      VStack { 
        LangsSetsCards()
      }
      .frame(maxWidth: .infinity)
      .frame(height: splitCopy.showSplit ? cutHeight() : .infinity)
      .clipShape(RoundedRectangle(cornerRadius: 41.5))
      if splitCopy.showSplit {
        ZStack {
          Capsule()
            .fill(.gray)
            .frame(width: colorScheme == .dark ? 150 : 100, height: 3)
            .padding(.vertical, 2)
          Rectangle() // Drag Gesture Area
            .fill(.white.opacity(0.001))
            .frame(height: 30)
            .gesture(dragGesture)
            .padding(-12)
        }
        
        VStack { 
          LangsSetsCards2()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 41.5))
      }
    }
    .frame(height: screenHeight)
    .ignoresSafeArea()
    .background(.blackWhite)
    .animation(.bouncy, value: splitCopy.showSplit)
    

  }
  
  
  private var dragGesture: some Gesture {
    DragGesture(minimumDistance: 0)
      .onChanged { value in
        bannerPositionY += value.translation.height
      }
      .onEnded { value in 
        switch bannerPositionY {
        case (screenHeight - 250)...: bannerPositionY = screenHeight - 250
        case ...275: bannerPositionY = 275
        default: bannerPositionY = bannerPositionY
        }
      }
  }
  
  func cutHeight() -> Double {
    switch bannerPositionY {
    case (screenHeight - 250.0)...: return screenHeight - 250
    case ...275.0: return 275
    default: return bannerPositionY
    }
  }
  
}



#Preview {
  @Previewable @StateObject var dataLangs = DataLangs()
  @Previewable @StateObject  var splitCopy: CopySplitManager = CopySplitManager()
  @Previewable @State var cardBuffer: [Card] = []
  @Previewable @State var setCutFrom: CardSet?
  SplitScreens()
    .environmentObject(dataLangs)
    .environmentObject(splitCopy)
}
