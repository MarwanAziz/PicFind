//
//  File.swift
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import ApiServices

class ApiServicesMock: ApiServices {
  var expectedResult: [APIImageData] = []
  var expectedError: NSError = NSError(domain: "expected error", code: -1, userInfo: nil)
  var returnError = false

  func searchImages(searchTerm: String) async throws -> [APIImageData] {
    if returnError {
      throw expectedError
    } else {
      expectedResult
    }
  }
}
