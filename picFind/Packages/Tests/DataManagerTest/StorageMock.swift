//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import AppStorage

final class StorageMock: Storage {
  private var images: [ImageDataModel] = []
  private var searches: [SearchDataModel] = []

  func storeImage(image: ImageDataModel) {
    images.append(image)
  }

  func fetchImages() -> [ImageDataModel] {
    return images
  }

  func deleteImage(image: ImageDataModel) {
    images.removeAll { $0.imageId == image.imageId }
  }

  func storeSearch(search: SearchDataModel) {
    searches.append(search)
  }

  func fetchAllSearch() -> [SearchDataModel] {
    return searches
  }

  func deleteSearch(search: SearchDataModel) {
    searches.removeAll { $0.searchTerm == search.searchTerm && $0.timestamp == search.timestamp }
  }
}
