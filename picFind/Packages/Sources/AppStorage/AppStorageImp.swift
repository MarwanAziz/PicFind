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

  func storeImage(image: ImageDataModel) async {
    context.insert(transform(image))
  }

  private func requestImages() async -> [ImageData] {
    let request = FetchDescriptor<ImageData>()
    let images = try? context.fetch(request)
    return images ?? []
  }

  func fetchImages() async -> [ImageDataModel] {
    let images = await requestImages()
    return images.map { transform($0) }
  }

  func deleteImage(image: ImageDataModel) async {
    let imageId = image.imageId
    do {
      try context.delete(model: ImageData.self, where: #Predicate<ImageData> { storedImage in
        storedImage.imageId == imageId
      })
    } catch {
      print("Unable to delete image \(image.imageId): \(error.localizedDescription)")
    }
  }

  func storeSearch(search: SearchDataModel) async {
    context.insert(transform(search))
  }

  private func requestSearch() async -> [SearchData] {
    let request = FetchDescriptor<SearchData>()
    let searches = try? context.fetch(request)
    return searches ?? []
  }

  func fetchAllSearch() async -> [SearchDataModel] {
    await requestSearch().map(transform(_:))
  }

  func deleteSearch(search: SearchDataModel) async {
    let searchTimestamp = search.timestamp
    do {
      try context.delete(model: SearchData.self, where: #Predicate { $0.timestamp == searchTimestamp})
    } catch {
      print("Unable to delete search \(searchTimestamp): \(error.localizedDescription)")
    }
  }
}
