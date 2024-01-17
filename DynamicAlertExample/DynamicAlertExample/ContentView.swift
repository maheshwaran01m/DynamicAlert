//
//  ContentView.swift
//  DynamicAlertExample
//
//  Created by MAHESHWARAN on 17/01/24.
//

import SwiftUI
import DynamicAlert

struct ContentView: View {
  
  @StateObject private var viewModel = ContentViewModel()
  
  var body: some View {
    VStack {
      Image(systemName: "globe")
        .imageScale(.large)
        .foregroundStyle(.tint)
      Text("Hello, world!")
    }
    .padding()
    
    .dynamicAlert(.init(get: {
      viewModel.message?.isEnabled != nil
    }, set: { isEnabled in
      if !isEnabled {
        viewModel.message = nil
      }
    }), title: viewModel.message?.title ?? "", message: viewModel.message?.message ?? "") {
      Button("Ok") {}
    }
  }
}

#Preview {
  ContentView()
}
