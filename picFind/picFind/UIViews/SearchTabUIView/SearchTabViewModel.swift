//
//  SearchTabViewModel.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import Foundation
import DataManager

extension SearchTabView {
  class ViewModel: ImageViewModel, ObservableObject {
    var searchResult: [DMImageDataModel] = []
    @Published var search: String = ""
    @Published var isSearching: Bool = false
    var searchHistory: [DMSearchDataModel] = []

    override init(dataManager: DataManager = DataManagerImp.shared) {
      super.init(dataManager: dataManager)
      fetchSearchHistory()
    }

    private func fetchSearchHistory() {
      searchHistory = dataManager.allSearch()
    }

    func searchImages() async {
      guard search.trimmingCharacters(in: .whitespaces).isEmpty == false else {
        return
      }
      await MainActor.run {
        isSearching = true
      }
      searchResult = await dataManager.searchImages(search: DMSearchDataModel(searchTerm: search, timestamp: Date()))
      await MainActor.run {
        storedImages = dataManager.allSavedImages()
        imagesGridViewModel.images = searchResult.map(transform(_ :))
        isSearching = false
        fetchSearchHistory()
      }
    }
  }
}
