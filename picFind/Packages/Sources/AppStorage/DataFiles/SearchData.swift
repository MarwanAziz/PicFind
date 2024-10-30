//
//
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import SwiftData

@Model
public class SearchData {
  var searchTerm: String
  var timestamp: Date

  public init(searchTerm: String, timestamp: Date) {
    self.searchTerm = searchTerm
    self.timestamp = timestamp
  }
}
