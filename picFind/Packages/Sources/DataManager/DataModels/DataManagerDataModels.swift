//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

public struct DMSearchDataModel {
  public let searchTerm: String
  public let timestamp: Date
  public init(searchTerm: String, timestamp: Date) {
    self.searchTerm = searchTerm
    self.timestamp = timestamp
  }
}

public struct DMImageDataModel {
  public let imageId: String
  public let title: String?
  public let imageDescription: String?
  public let width: Int?
  public let height: Int?
  public let size: Int?
  public let views: Int?
  public let link: String?

  public init(
    imageId: String,
    title: String? = nil,
    imageDescription: String? = nil,
    width: Int? = nil,
    height: Int? = nil,
    size: Int? = nil,
    views: Int? = nil,
    link: String? = nil
  ) {
    self.imageId = imageId
    self.title = title
    self.imageDescription = imageDescription
    self.width = width
    self.height = height
    self.size = size
    self.views = views
    self.link = link
  }
}
