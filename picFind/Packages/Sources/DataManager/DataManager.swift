//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation
import AppStorage
import ApiServices

protocol DataManager {
  func initialise(storage: Storage, apiServices: ApiServices)
  func searchImages(search: DMSearchDataModel) async -> [DMImageDataModel]
  func saveImage(image: DMImageDataModel) async
  func deleteSavedImage(image: DMImageDataModel) async
  func allSavedImages() async -> [DMImageDataModel]
  func saveSearch(search: DMSearchDataModel) async
  func deleteSearch(search: DMSearchDataModel) async
  func allSearch() async -> [DMSearchDataModel]
}

extension DataManager {
  internal var maxStoredNumberOfSearch: Int {
    10
  }
}
