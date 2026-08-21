//
//  EditBtn.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import SwiftUI

struct EditBtn: View {
    var body: some View {
      Button(role: .confirm){ 
        
      } label: {
        Image(systemName: "play")
      }
      .toolbarRole(.editor)
    }
}

#Preview {
    EditBtn()
}
