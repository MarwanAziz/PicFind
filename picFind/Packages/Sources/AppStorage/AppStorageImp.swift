//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import SwiftData

extension AppStorage {
  private func transform(_ image: ImageDataModel) -> ImageData {
    ImageData(
      imageId: image.imageId,
      title: image.title,
      description: image.imageDescription,
      width: image.width,
      height: image.height,
      size: image.size,
      views: image.views,
      link: image.link
    )
  }

  private func transform(_ image: ImageData) -> ImageDataModel {
    ImageDataModel(
      imageId: image.imageId,
      title: image.title,
      imageDescription: image.imageDescription,
      width: image.width,
      height: image.height,
      size: image.size,
      views: image.views,
      link: image.link
    )
  }

  private func transform(_ search: SearchDataModel) -> SearchData {
    SearchData(searchTerm: search.searchTerm, timestamp: search.timestamp)
  }

  private func transform(_ search: SearchData) -> SearchDataModel {
    SearchDataModel(searchTerm: search.searchTerm, timestamp: search.timestamp)
  }

  public func storeImage(image: ImageDataModel) {
    context.insert(transform(image))
    try? context.save()
  }

  private func requestImages() -> [ImageData] {
    let request = FetchDescriptor<ImageData>()
    do {
      let images = try context.fetch(request)
      return images
    } catch {
      return []
    }
  }

  public func fetchImages() -> [ImageDataModel] {
    let images = requestImages()
    return images.map { transform($0) }
  }

  public func deleteImage(image: ImageDataModel) {
    let imageId = image.imageId
    do {
      try context.delete(model: ImageData.self, where: #Predicate<ImageData> { storedImage in
        storedImage.imageId == imageId
      })
    } catch {
      print("Unable to delete image \(image.imageId): \(error.localizedDescription)")
    }
  }

  public func storeSearch(search: SearchDataModel) {
    context.insert(transform(search))
    try? context.save()
  }

  private func requestSearch() -> [SearchData] {
    let request = FetchDescriptor<SearchData>()
    let searches = try? context.fetch(request)
      .sorted(by: { search1, search2 in
        search1.timestamp > search2.timestamp
      })
    return searches ?? []
  }

  public func fetchAllSearch() -> [SearchDataModel] {
    requestSearch().map(transform(_:))
  }

  public func deleteSearch(search: SearchDataModel) {
    let searchTimestamp = search.timestamp
    do {
      try context.delete(model: SearchData.self, where: #Predicate { $0.timestamp == searchTimestamp})
    } catch {
      print("Unable to delete search \(searchTimestamp): \(error.localizedDescription)")
    }
  }
}
