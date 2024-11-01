//
//  SearchTabViewModelTest.swift
//  picFindTests
//
//  Created by Marwan Aziz on 01/11/2024.
//

import Foundation

import XCTest
import Combine
@testable import picFind
import DataManager
import ApiServices
import AppStorage

class MockDataManager: DataManager {
  var initialiseCalled = false
  var searchImagesCalled = false
  var saveImageCalled = false
  var deleteSavedImageCalled = false
  var saveSearchCalled = false
  var deleteSearchCalled = false

  var savedImages: [DMImageDataModel] = []
  var savedSearches: [DMSearchDataModel] = []
  var searchResults: [DMImageDataModel] = []

  func initialise(storage: Storage, apiServices: ApiServices) {
    initialiseCalled = true
  }

  func searchImages(search: DMSearchDataModel) async -> [DMImageDataModel] {
    searchImagesCalled = true
    saveSearch(search: search)
    return searchResults
  }

  func saveImage(image: DMImageDataModel) {
    saveImageCalled = true
    savedImages.append(image)
  }

  func deleteSavedImage(image: DMImageDataModel) {
    deleteSavedImageCalled = true
    savedImages.removeAll { $0.imageId == image.imageId }
  }

  func allSavedImages() -> [DMImageDataModel] {
    return savedImages
  }

  func saveSearch(search: DMSearchDataModel) {
    saveSearchCalled = true
    if savedSearches.count >= 10 {
      savedSearches.removeFirst() // Mimic capped search history
    }
    savedSearches.append(search)
  }

  func deleteSearch(search: DMSearchDataModel) {
    deleteSearchCalled = true
    savedSearches.removeAll { $0.searchTerm == search.searchTerm }
  }

  func allSearch() -> [DMSearchDataModel] {
    return savedSearches
  }
}


class SearchTabViewModelTests: XCTestCase {
  var viewModel: SearchTabView.ViewModel!
  var mockDataManager: MockDataManager!
  var cancellables: Set<AnyCancellable> = []

  override func setUp() {
    super.setUp()
    mockDataManager = MockDataManager()
    viewModel = SearchTabView.ViewModel(dataManager: mockDataManager)
  }

  override func tearDown() {
    viewModel = nil
    mockDataManager = nil
    cancellables.removeAll()
    super.tearDown()
  }

  func testSearchImagesSuccess() async {
    viewModel.search = "Nature"
    let result1 = DMImageDataModel(imageId: "1", title: "Mountain", imageDescription: "A beautiful mountain", width: 100, height: 100, size: 5000, views: 100, link: "link")
    let result2 = DMImageDataModel(imageId: "2", title: "title 2", imageDescription: "description 2", width: 100, height: 100, size: 100, views: 100, link: "linkn2")
    mockDataManager.searchResults = [result1, result2]

    await viewModel.searchImages()

    XCTAssertTrue(mockDataManager.searchImagesCalled, "searchImages should be called on dataManager")
    XCTAssertEqual(viewModel.searchResult.count, mockDataManager.searchResults.count)
    XCTAssertEqual(viewModel.imagesGridViewModel.images.count, 2, "GridViewModel should contain two images from search result")
  }

  func testSearchImagesEmptyInput() async {
    viewModel.search = ""
    await viewModel.searchImages()
    XCTAssertFalse(mockDataManager.searchImagesCalled, "searchImages should not be called on dataManager for empty search input")
  }

  func testSearchHistoryLimit() {
    for i in 1...15 {
      let search = DMSearchDataModel(searchTerm: "Search \(i)", timestamp: Date())
      mockDataManager.saveSearch(search: search)
    }
    XCTAssertEqual(mockDataManager.savedSearches.count, 10, "Search history should not exceed maxStoredNumberOfSearch limit")
  }

  func testIsSearchingState() async {
    var isSearchingChanges = [Bool]()
    viewModel.$isSearching
      .sink { isSearchingChanges.append($0) }
      .store(in: &cancellables)
    viewModel.search = "Ocean"
    await viewModel.searchImages()
    XCTAssertEqual(isSearchingChanges, [false, true, false], "isSearching should start false, change to true during search, and revert to false after search completes")
  }
}
