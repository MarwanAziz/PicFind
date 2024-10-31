//
//  File.swift
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

import XCTest
import AppStorage
import SwiftData
import ApiServices
@testable import DataManager

final class DataManagerTests: XCTestCase {

  var dataManager: DataManager!
  var apiService: ApiServicesMock!

  override func setUp() {
    super.setUp()
    dataManager = DataManagerImp.shared
    apiService = ApiServicesMock()
    dataManager.initialise(storage: StorageMock(), apiServices: apiService)
  }

  override func tearDown() {
    dataManager = nil
    apiService = nil
    super.tearDown()
  }

  var apiImageJsonDate: String {
    """
    {
      "id": "12345",
      "title": "Sample Image",
      "description": "A beautiful sample image.",
      "width": 800,
      "height": 600,
      "size": 2048,
      "views": 150,
      "favorite": true,
      "link": "https://example.com/sample.jpg"
    }
    """
  }

  var apiImageData: APIImageData? {
    if let jsonData = apiImageJsonDate.data(using: .utf8) {
      do {
        let decoder = JSONDecoder()
        let imageData = try decoder.decode(APIImageData.self, from: jsonData)
        return imageData
      } catch {
        print("Error decoding JSON: \(error)")
        return nil
      }
    }
    return nil
  }

  func testSearchImagesSuccess() async {
    // Given
    let searchTerm = "swift"
    let dmSearchDataModel = DMSearchDataModel(searchTerm: searchTerm, timestamp: Date())
    var expectedResult: [APIImageData] = []
    if let expectedImage = apiImageData {
      expectedResult = [expectedImage]
    }

    apiService.returnError = false
    apiService.expectedResult = expectedResult
    // When
    let images = await dataManager.searchImages(search: dmSearchDataModel)

    // Then
    XCTAssertEqual(images.count, 1)
    XCTAssertEqual(images.first?.imageId, expectedResult.first?.id)
  }

  func testSaveSearch() async {
    // Given
    let searchTerm = "swift"
    let dmSearchDataModel = DMSearchDataModel(searchTerm: searchTerm, timestamp: Date())

    // When
    await dataManager.saveSearch(search: dmSearchDataModel)
    let allSearch = await dataManager.allSearch()

    // Then
    XCTAssertEqual(allSearch.count, 1)
  }

  func testDeleteSavedImage() async {
    // Given
    let image = DMImageDataModel(imageId: "1", title: "Swift", imageDescription: "Image", width: 100, height: 100, size: 1024, views: 10, link: "https://example.com/swift.png")

    // When
    await dataManager.deleteSavedImage(image: image)
    let allImages = await dataManager.allSavedImages()
    // Then
    XCTAssertEqual(allImages.count, 0)
  }

  func testAllSearch() async {
    // Given
    let expectedSearchTerm = "swift"
    let dmSearchDataModel = DMSearchDataModel(searchTerm: expectedSearchTerm, timestamp: Date())
    let _ = await dataManager.searchImages(search: dmSearchDataModel)
    // When
    let searches = await dataManager.allSearch()

    // Then
    XCTAssertEqual(searches.count, 1)
    XCTAssertEqual(searches.first?.searchTerm, expectedSearchTerm)
  }
}
