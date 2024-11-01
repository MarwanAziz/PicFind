//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import AppStorage
import ApiServices

public protocol DataManager {
  func initialise(storage: Storage, apiServices: ApiServices)
  func searchImages(search: DMSearchDataModel) async -> [DMImageDataModel]
  func saveImage(image: DMImageDataModel)
  func deleteSavedImage(image: DMImageDataModel)
  func allSavedImages() -> [DMImageDataModel]
  func saveSearch(search: DMSearchDataModel)
  func deleteSearch(search: DMSearchDataModel)
  func allSearch() -> [DMSearchDataModel]
}

extension DataManager {
  internal var maxStoredNumberOfSearch: Int {
    10
  }
}
