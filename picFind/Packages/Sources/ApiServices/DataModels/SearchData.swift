//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public struct SearchData: Codable {
  let id: String?
  let title: String?
  let description: String?
  let views: Int?
  let images: [ImageData]?
}
