//
//  ContentViewModel.swift
//  DynamicAlertExample
//
//  Created by MAHESHWARAN on 17/01/24.
//

import SwiftUI
import DynamicAlert

class ContentViewModel: ObservableObject {
  
  @Published var message: DynamicAlertMessage?
  
  let manager = DynamicAlert.shared
  
  init() {
    fetchMessages()
  }
  
  private func fetchMessages() {
    guard let url = URL(string: "https://maheshwaran01m.github.io/DynamicAlert/messages.json") else { return }
    manager.getMessages(for: url) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let message):
        DispatchQueue.main.async {
          self.message = message.first
        }
      case .failure(let failure):
        print(failure.localizedDescription)
      }
    }
  }
}
