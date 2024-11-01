//
//  File.swift
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

public protocol Storage {
  func storeImage(image: ImageDataModel)
  func fetchImages() -> [ImageDataModel]
  func deleteImage(image: ImageDataModel)
  func storeSearch(search: SearchDataModel)
  func fetchAllSearch() -> [SearchDataModel]
  func deleteSearch(search: SearchDataModel)
}
