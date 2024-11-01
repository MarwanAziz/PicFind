//
//  FavouriteImagesViewModel.swift
//  picFind
//
//  Created by Marwan Aziz on 01/11/2024.
//

import Foundation
import DataManager

extension FavouriteImagesView {
  class ViewModel: ImageViewModel, ObservableObject {

    override init(dataManager: DataManager = DataManagerImp.shared) {
      super.init(dataManager: dataManager)
      onImageFavouriteChanged = { [weak self] in
        self?.fetchStoredImaged()
      }
      fetchStoredImaged()

    }

    func fetchStoredImaged() {
      storedImages =  dataManager.allSavedImages()
      imagesGridViewModel.images = storedImages?.map(transform(_:)) ?? []
    }
  }
}
