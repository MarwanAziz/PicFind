//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public struct APIImageData: Codable {
  public let id: String?
  public let title: String?
  public let description: String?
  public let width: Int?
  public let height: Int?
  public let size: Int?
  public let views: Int?
  public let favorite: Bool?
  public let link: String?
}
