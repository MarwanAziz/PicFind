//
//  File.swift
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation
@testable import ApiServices

class MockNetworkSession: NetworkSession {
  var data: Data?
  var response: URLResponse?
  var error: Error?

  func data(for request: URLRequest) async throws -> (Data, URLResponse) {
    if let error = error {
      throw error
    }
    guard let data = data, let response = response else {
      throw NSError(domain: "MockNetworkSessionError", code: -1, userInfo: nil)
    }
    return (data, response)
  }
}
