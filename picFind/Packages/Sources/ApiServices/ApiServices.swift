//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public protocol ApiServices {
  func searchImages(searchTerm: String) async throws -> [APIImageData]
}

extension ApiServices {
  var apiEndPoint: String {
    "https://api.imgur.com/3/gallery/search"
  }

  var allowedImageTypes: String {
    "png,jpg,webp"
  }

  var cientID: String {
    "3824c707ce9477d"
  }
}
