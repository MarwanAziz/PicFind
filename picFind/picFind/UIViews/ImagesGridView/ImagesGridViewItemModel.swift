//
//  ImagesGridViewItemModel.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import Foundation
import DataManager

extension ImagesGridViewItem {
  class ViewModel: ObservableObject, Hashable {
    @Published var isFavourite = false
    var modelId = UUID()
    private let imageId: String
    private let imageTitle: String?
    private let imageDescription: String?
    private let imageUrl: String?
    private let dataManager: DataManager
    private let imageWidth: Int?
    private let imageHeight: Int?
    private let imageViewsCount: Int?
    private let imageSize: Int?

    init(
      dataManager: DataManager = DataManagerImp.shared,
      imageId: String,
      isFavourite: Bool = false,
      imageTitle: String?,
      imageDescription: String?,
      imageUrl: String?,
      imageWidth: Int?,
      imageHeight: Int?,
      imageSize: Int?,
      imageViewsCount: Int?
    ) {
      self.dataManager = dataManager
      self.imageId = imageId
      self.isFavourite = isFavourite
      self.imageTitle = imageTitle
      self.imageDescription = imageDescription
      self.imageUrl = imageUrl
      self.imageWidth = imageWidth
      self.imageHeight = imageHeight
      self.imageViewsCount = imageViewsCount
      self.imageSize = imageSize
    }

    var descriptionText: String {
      imageDescription ?? ""
    }

    var imageURL: URL {
      if let url =  URL(string: imageUrl ?? "https://www.google.com/") {
        return url
      }
      return URL(string:"https://www.google.com/")!
    }

    var favouriteButtonImageName: String {
      isFavourite ? "heart.fill" : "heart"
    }

    func onFavouritedButtonTapped() {
      let image = DMImageDataModel(
        imageId: imageId,
        title: imageTitle,
        imageDescription: imageDescription,
        width: imageWidth,
        height: imageHeight,
        size: imageSize,
        views: imageViewsCount,
        link: imageUrl
      )
      if isFavourite {
        dataManager.deleteSavedImage(image: image)
      } else {
        dataManager.saveImage(image: image)
      }
      isFavourite.toggle()
    }

    // MARK: Hasable

    static func == (lhs: ImagesGridViewItem.ViewModel, rhs: ImagesGridViewItem.ViewModel) -> Bool {
      lhs.imageId == rhs.imageId
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(imageId)
    }
  }
}
