//
//  DynamicAlertMessage.swift
//
//
//  Created by MAHESHWARAN on 17/01/24.
//

import Foundation

public struct DynamicAlertMessage: Codable {
  public var id: Int
  public var bundleID: String
  public var title: String
  public var message: String
  public var buttonTitle: String
  public var isEnabled: Bool
  
  public init(id: Int, bundleID: String, title: String, message: String, buttonTitle: String, isEnabled: Bool) {
    self.id = id
    self.bundleID = bundleID
    self.title = title
    self.message = message
    self.buttonTitle = buttonTitle
    self.isEnabled = isEnabled
  }
}
