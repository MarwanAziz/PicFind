//
//  ImageViewModel.swift
//  picFind
//
//  Created by Marwan Aziz on 01/11/2024.
//

import Foundation
import DataManager
import Combine

class ImageViewModel {
  let dataManager: DataManager
  private var gridViewModel: ImagesGridView.ViewModel?
  var onImageFavouriteChanged: (() -> Void)? = nil
  private var bag: [AnyCancellable] = []
  var storedImages: [DMImageDataModel]? = nil

  init(dataManager: DataManager = DataManagerImp.shared) {
    self.dataManager = dataManager
  }

  var imagesGridViewModel: ImagesGridView.ViewModel {
    if let gridViewModel {
      return gridViewModel
    }
    gridViewModel = ImagesGridView.ViewModel()
    return gridViewModel!
  }

  func transform(_ image: DMImageDataModel) -> ImagesGridViewItem.ViewModel {
    let isFavourited = storedImages?.first(where: { $0.imageId == image.imageId}) != nil
    let image = ImagesGridViewItem.ViewModel(
      imageId: image.imageId,
      isFavourite: isFavourited,
      imageTitle: image.title,
      imageDescription: image.imageDescription,
      imageUrl: image.link,
      imageWidth: image.width,
      imageHeight: image.height,
      imageSize: image.size,
      imageViewsCount: image.views
    )

    if let onImageFavouriteChanged {
      image.$isFavourite
        .dropFirst()
        .sink { _ in
        onImageFavouriteChanged()
      }
      .store(in: &bag)
    }
    return image
  }
}
