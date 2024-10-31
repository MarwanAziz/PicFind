//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import AppStorage
import ApiServices

public class DataManagerImp: DataManager {

  static let shared: DataManager = DataManagerImp()
  private var appStorage: Storage = AppStorage.shared
  private var apiServices: ApiServices = ApiServicesImp()

  func initialise(storage: Storage, apiServices: ApiServices) {
    appStorage = storage
    self.apiServices = apiServices
  }

  func transform(_ model: ImageDataModel) -> DMImageDataModel {
    return DMImageDataModel(
      imageId: model.imageId,
      title: model.title,
      imageDescription: model.imageDescription,
      width: model.width,
      height: model.height,
      size: model.size,
      views: model.views,
      link: model.link
    )
  }

  func transform(_ model: DMImageDataModel) -> ImageDataModel {
    return ImageDataModel(
      imageId: model.imageId,
      title: model.title,
      imageDescription: model.imageDescription,
      width: model.width,
      height: model.height,
      size: model.size,
      views: model.views,
      link: model.link
    )
  }

  func transform(_ model: SearchDataModel) -> DMSearchDataModel {
    return DMSearchDataModel(
      searchTerm: model.searchTerm,
      timestamp: model.timestamp
    )
  }

  func transform(_ model: DMSearchDataModel) -> SearchDataModel {
    return SearchDataModel(
      searchTerm: model.searchTerm,
      timestamp: model.timestamp
    )
  }

  func transform(_ model: APIImageData) -> DMImageDataModel {
    DMImageDataModel(
      imageId: model.id ?? "",
      title: model.title,
      imageDescription: model.description,
      width: model.width,
      height: model.height,
      size: model.size,
      views: model.views,
      link: model.link
    )
  }

  private func deleteOldestSearchIfNeeded() async {
    let searches = await allSearch()
    if searches.count >= maxStoredNumberOfSearch {
      let lastSearch = await allSearch().sorted { search1, search2 in
        search1.timestamp < search2.timestamp
      }
        .last
      if let lastSearch {
        await deleteSearch(search: lastSearch)
      }
    }
  }

  public func saveSearch(search: DMSearchDataModel) async {
    await deleteOldestSearchIfNeeded()
    await appStorage.storeSearch(search: transform(search))
  }

  public func searchImages(search: DMSearchDataModel) async -> [DMImageDataModel] {
    do {
      let searchResult = try await apiServices.searchImages(searchTerm: search.searchTerm)
      await saveSearch(search: search)
      return searchResult.map(transform(_:))
    } catch {
      print("search error: \(error.localizedDescription)")
      return []
    }
  }

  public func saveImage(image: DMImageDataModel) async {
    await appStorage.storeImage(image: transform(image))
  }
  
  public func deleteSavedImage(image: DMImageDataModel) async {
    await appStorage.deleteImage(image: transform(image))
  }

  public func allSavedImages() async -> [DMImageDataModel] {
    let images = await appStorage.fetchImages()
    return images.map(transform(_:))
  }

  public func deleteSearch(search: DMSearchDataModel) async {
    await appStorage.deleteSearch(search: transform(search))
  }
  
  public func allSearch() async -> [DMSearchDataModel] {
    let searches = await appStorage.fetchAllSearch()
    return searches.map(transform(_:))
  }
}