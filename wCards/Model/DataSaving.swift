//
//  DataSaving.swift
//  wCards
//
//  Created by Fedor Komov on 21.08.2026.
//

import Foundation
import SwiftUI
import Combine

class DataLangs: ObservableObject {
  @Published var allLangs: AllLanguages {
    didSet {
      saveQueue.async {
        self.saveDataToUserDefaults()
      }
//      print("Что-то сохранилось")
    }
  }
  
  private let saveQueue = DispatchQueue(label: "com.app.savequeue")
  
  func saveDataToUserDefaults() {
    if let encoded = try? JSONEncoder().encode(allLangs) {
      UserDefaults.standard.set(encoded, forKey: "allLangs")
    }
    print("Что-то сохранилось по вводу")
  }
  
  init() {
    // Load settings when the manager is initialized
    if let savedLanguages = UserDefaults.standard.data(forKey: "allLangs") {
      if let decodedLanguages = try? JSONDecoder().decode(
        AllLanguages.self,
        from: savedLanguages
      ) {
        self.allLangs = decodedLanguages
//        print("Что-то ЗАГЛУЗИЛОСЬ!")
        return
      }
    }
    // Use default values if no saved settings are found
    self.allLangs = AllLanguages()
    print("НИХУЯ НЕ ЗАГЛУЗИЛОСЬ!")
  }
  
  
  private var saveTask: Task<Void, Never>?
  
  func saveTrigger() {
    
    saveTask?.cancel()
    
    saveTask = Task {
      do {
        try await Task.sleep(nanoseconds: 1_000_000_000)
        guard !Task.isCancelled else { return }
        await self.performHeavySave()
      } catch {
//        print("Saving is breaked")
        
      }
    }
  }
  
  private func performHeavySave() async {
    saveQueue.async {
      self.saveDataToUserDefaults()
    }
  }
}

