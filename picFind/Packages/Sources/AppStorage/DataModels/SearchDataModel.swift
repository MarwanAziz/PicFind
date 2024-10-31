//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

public struct SearchDataModel {
  public let searchTerm: String
  public let timestamp: Date

  public init(searchTerm: String, timestamp: Date) {
    self.searchTerm = searchTerm
    self.timestamp = timestamp
  }
}
