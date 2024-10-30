//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public struct ImgurSearchResponse: Codable {
  let data: [SearchData]?
  let success: Bool?
  let status: Int?
}