//
//  
//
//  Created by Marwan Aziz on 30/10/2024.
//

import Foundation

import XCTest
@testable import AppStorage
import SwiftData

final class AppStorageTests: XCTestCase {

  var appStorage: AppStorage!
  var mockModelContainer: ModelContainer {
    {
      let schema = Schema([
        ImageData.self, SearchData.self
      ])
      let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)

      do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
      } catch {
        fatalError("Could not create ModelContainer: \(error)")
      }
    }()
  }

  override func setUp() {
    super.setUp()
    appStorage = AppStorage.shared
    appStorage.updateModelContainer(container: mockModelContainer)
  }

  override func tearDown() {
    appStorage = nil
    super.tearDown()
  }

  func testStoreImage() async {
    // Given
    let image = ImageDataModel(imageId: "123", title: "Test Image", imageDescription: "A test image", width: 100, height: 100, size: 1024, views: 10, link: "https://example.com/image.jpg")

    // When
    await appStorage.storeImage(image: image)

    // Then
    let storedImages = await appStorage.fetchImages()
    XCTAssertEqual(storedImages.count, 1)
    XCTAssertEqual(storedImages.first?.imageId, "123")
  }

  func testFetchImages() async {
    // Given
    let image = ImageDataModel(imageId: "456", title: "Another Test Image", imageDescription: "Another test image", width: 200, height: 200, size: 2048, views: 20, link: "https://example.com/another_image.jpg")
    await appStorage.storeImage(image: image)

    // When
    let images = await appStorage.fetchImages()

    // Then
    XCTAssertEqual(images.count, 1)
    XCTAssertEqual(images.first?.imageId, "456")
  }

  func testDeleteImage() async {
    // Given
    let image = ImageDataModel(imageId: "789", title: "Delete Test Image", imageDescription: "This image will be deleted", width: 150, height: 150, size: 1500, views: 15, link: "https://example.com/delete_image.jpg")
    await appStorage.storeImage(image: image)

    // When
    await appStorage.deleteImage(image: image)

    // Then
    let images = await appStorage.fetchImages()
    XCTAssertEqual(images.count, 0)
  }

  // MARK: - Search Tests

  func testStoreSearch() async {
    // Given
    let search = SearchDataModel(searchTerm: "Test", timestamp: Date())

    // When
    await appStorage.storeSearch(search: search)

    // Then
    let storedSearches = await appStorage.fetchAllSearch()
    XCTAssertEqual(storedSearches.count, 1)
    XCTAssertEqual(storedSearches.first?.searchTerm, "Test")
  }

  func testFetchAllSearch() async {
    // Given
    let search1 = SearchDataModel(searchTerm: "First Search", timestamp: Date())
    let search2 = SearchDataModel(searchTerm: "Second Search", timestamp: Date())
    await appStorage.storeSearch(search: search1)
    await appStorage.storeSearch(search: search2)

    // When
    let searches = await appStorage.fetchAllSearch()

    // Then
    XCTAssertEqual(searches.count, 2)
    XCTAssertEqual(searches[0].searchTerm, "First Search")
    XCTAssertEqual(searches[1].searchTerm, "Second Search")
  }

  func testDeleteSearch() async {
    // Given
    let search = SearchDataModel(searchTerm: "Delete This", timestamp: Date())
    await appStorage.storeSearch(search: search)

    // When
    await appStorage.deleteSearch(search: search)

    // Then
    let searches = await appStorage.fetchAllSearch()
    XCTAssertEqual(searches.count, 0)
  }
}
