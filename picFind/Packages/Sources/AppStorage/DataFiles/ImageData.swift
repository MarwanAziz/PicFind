//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import SwiftData

@Model
class ImageData {
  var imageId: String
  var title: String?
  var imageDescription: String?
  var width: Int?
  var height: Int?
  var size: Int?
  var views: Int?
  var link: String?

  public init(imageId: String, title: String? = nil, description: String? = nil, width: Int? = nil, height: Int? = nil, size: Int? = nil, views: Int? = nil, link: String? = nil) {
    self.imageId = imageId
    self.title = title
    self.imageDescription = description
    self.width = width
    self.height = height
    self.size = size
    self.views = views
    self.link = link
  }
}
