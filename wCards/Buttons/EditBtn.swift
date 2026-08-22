//
//  EditBtn.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct EditBtn: View {
  @Binding var value: Bool
    var body: some View {
      Button(role: .confirm){ 
        value.toggle()
      } label: {
        Image(systemName: "square.and.pencil")
          .resizable()
          .frame(width: 25, height: 25)
        if value {
          Text("Edit...")
        }
      }
      .buttonBorderShape(value ? .capsule : .circle)
    }
}

#Preview {
  EditBtn(value: .constant(false))
}
