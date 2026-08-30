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
        if value {
          Text("Done")
            .font(.system(size: 20))
            .frame(width: 50, height: 25)
        } else {
            Image(systemName: "square.and.pencil")
              .resizable()
              .frame(width: 25, height: 25)
        }
      }
      .buttonBorderShape(value ? .capsule : .circle)
    }
}

#Preview {
  EditBtn(value: .constant(true))
}
