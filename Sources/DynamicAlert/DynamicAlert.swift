// DynamicAlert

// Copyright © 2024 MAHESHWARAN

import Foundation
import Combine

public final class DynamicAlert {
  
  public static let shared = DynamicAlert()
  
  private init() {}
}

// MARK: - Get

public extension DynamicAlert {
  
  func get<Output: Decodable>(
    _ url: URL,
    urlConfig config: URLSessionConfiguration? = nil,
    dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .iso8601,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
    debugPrintEnabled: Bool = false,
    completion: @escaping (Result<Output, Error>) -> Void) {
      
      let session = URLSession(configuration: config ?? urlSessionConfiguration)
      
      session
        .dataTask(with: url) { data, response, error in
          guard error == nil else {
            completion(.failure(error ?? URLError(.badServerResponse)))
            return
          }
          guard let data else {
            completion(.failure(URLError(.cannotDecodeRawData)))
            return
          }
          do {
            if debugPrintEnabled {
              // debugPrint(data.description)
              print(try JSONSerialization.jsonObject(with: data))
            }
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = dateDecodingStategy
            jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
            
            let decoder = try jsonDecoder.decode(Output.self, from: data)
            completion(.success(decoder))
          } catch {
            completion(.failure(URLError(.cannotDecodeContentData)))
          }
        }
        .resume()
    }
  
  
  func get<Output: Decodable>(
    _ url: URL,
    urlConfig config: URLSessionConfiguration? = nil,
    dateDecodingStategy: JSONDecoder.DateDecodingStrategy = .iso8601,
    keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,
    debugPrintEnabled: Bool = false) -> AnyPublisher<Output, Error> {
      
      let session = URLSession(configuration: config ?? urlSessionConfiguration)
      
      let jsonDecoder = JSONDecoder()
      jsonDecoder.dateDecodingStrategy = dateDecodingStategy
      jsonDecoder.keyDecodingStrategy = keyDecodingStrategy
      
      return session
        .dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: Output.self, decoder: jsonDecoder)
        .eraseToAnyPublisher()
    }
}

public extension DynamicAlert {
  
  var urlSessionConfiguration: URLSessionConfiguration {
    let config = URLSessionConfiguration.default
    config.allowsExpensiveNetworkAccess = false
    config.allowsConstrainedNetworkAccess = false
    config.waitsForConnectivity = true
    
    return config
  }
}
