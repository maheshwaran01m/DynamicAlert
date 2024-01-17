//
//  AlertModifier.swift
//
//
//  Created by MAHESHWARAN on 17/01/24.
//

import SwiftUI

public extension DynamicAlert {
  
  struct AlertModifier: ViewModifier {
    
    @Binding var dynamicAlert: DynamicAlertMessage
    
    public init(_ dynamicAlert: Binding<DynamicAlertMessage>) {
      _dynamicAlert = dynamicAlert
    }
    
    public func body(content: Content) -> some View {
      content
        .dynamicAlert($dynamicAlert.isEnabled, title: dynamicAlert.title, message: dynamicAlert.message) {
          Button(dynamicAlert.buttonTitle) {}
        }
    }
  }
}

extension View {
  
  public func dynamicAlert<V: View>(_ isPresented: Binding<Bool>, title: String, message: String, @ViewBuilder action: () -> V) -> some View {
    self
      .alert(title, isPresented: isPresented, actions: action) {
        Text(message)
      }
  }
}
