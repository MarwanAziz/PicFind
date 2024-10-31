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

  func storeImage(image: ImageDataModel) async {
    images.append(image)
  }

  func fetchImages() async -> [ImageDataModel] {
    return images
  }

  func deleteImage(image: ImageDataModel) async {
    images.removeAll { $0.imageId == image.imageId }
  }

  func storeSearch(search: SearchDataModel) async {
    searches.append(search)
  }

  func fetchAllSearch() async -> [SearchDataModel] {
    return searches
  }

  func deleteSearch(search: SearchDataModel) async {
    searches.removeAll { $0.searchTerm == search.searchTerm && $0.timestamp == search.timestamp }
  }
}
