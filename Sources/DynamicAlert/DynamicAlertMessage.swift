//
//  DynamicAlertMessage.swift
//
//
//  Created by MAHESHWARAN on 17/01/24.
//

import Foundation

public struct DynamicAlertMessage: Codable {
  public var id: Int
  public var title: String
  public var message: String
  public var buttonTitle: String
  public var isEnabled: Bool
  
  public init(id: Int, title: String, message: String, buttonTitle: String, isEnabled: Bool) {
    self.id = id
    self.title = title
    self.message = message
    self.buttonTitle = buttonTitle
    self.isEnabled = isEnabled
  }
}

public extension DynamicAlertMessage {
  
  enum CodingKeys: CodingKey {
    case id, title, message, buttonTitle, isEnabled
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.title = try container.decode(String.self, forKey: .title)
    self.message = try container.decode(String.self, forKey: .message)
    self.buttonTitle = try container.decode(String.self, forKey: .buttonTitle)
    self.isEnabled = try container.decode(Bool.self, forKey: .isEnabled)
  }
  
  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.title, forKey: .title)
    try container.encode(self.message, forKey: .message)
    try container.encode(self.buttonTitle, forKey: .buttonTitle)
    try container.encode(self.isEnabled, forKey: .isEnabled)
  }
}
