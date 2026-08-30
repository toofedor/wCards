//
//  BackCardView.swift
//  wCards
//
//  Created by Fedor Komov on 20.08.2026.
//

import SwiftUI

struct BackCardView: View {
  let isFlipped: Bool
  let isBackSideShown: Bool
  let angle: Double
  let word: String
  @Binding var isOn: Bool
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 15)
        .fill(.white)
      RoundedRectangle(cornerRadius: 15)
        .fill(.green.gradient.quaternary)
        .shadow(color: .green1.opacity(0.5), radius: 10, x: 0, y: 10)
        .overlay(
          VStack(spacing: 20) {
            Text(word)
              .font(.title)
              .foregroundStyle(.green1)
              .multilineTextAlignment(.center)
              .padding()
          }
        )
      VStack(){
        HStack(){
          Spacer()
        MyToggle(isOn: $isOn)
            .hueRotation(.degrees(-50))
            .opacity(0.25)
            .padding(20)
        }
        Spacer()
      }
    }
    .opacity(isBackSideShown ? 1 : 0)
    .rotation3DEffect(.degrees(angle - 180), axis: (x: 1, y: 0, z: 0))
    
  }
}

#Preview {
  let word: String  = "Кот"
  BackCardView(isFlipped: true, isBackSideShown: true, angle: 180, word: word, isOn: .constant(false))
    .frame(width: 300, height: 150)
}
