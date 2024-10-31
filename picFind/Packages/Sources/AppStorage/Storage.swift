//
//  File.swift
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

public protocol Storage {
  func storeImage(image: ImageDataModel) async
  func fetchImages() async -> [ImageDataModel]
  func deleteImage(image: ImageDataModel) async
  func storeSearch(search: SearchDataModel) async
  func fetchAllSearch() async -> [SearchDataModel]
  func deleteSearch(search: SearchDataModel) async
}
