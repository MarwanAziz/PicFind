//
//  FavouriteImagesView.swift
//  picFind
//
//  Created by Marwan Aziz on 01/11/2024.
//

import SwiftUI

struct FavouriteImagesView: View {
  @StateObject var viewModel: ViewModel
  var body: some View {
    NavigationSplitView {
      ImagesGridView(viewModel: viewModel.imagesGridViewModel)
        .navigationTitle("Favourite")
        .navigationBarTitleDisplayMode(.inline)
    } detail: {}
      .padding(.horizontal, 8)
      .tabItem { Label("Favourite", systemImage: "heart") }
      .onAppear {
        viewModel.fetchStoredImaged()
      }
  }
}

#Preview {
  let viewModel = FavouriteImagesView.ViewModel()
  let images = [
    ImagesGridViewItem.ViewModel(
      imageId: "1",
      isFavourite: false,
      imageTitle: nil,
      imageDescription: "image",
      imageUrl: "image",
      imageWidth: nil,
      imageHeight: nil,
      imageSize: nil,
      imageViewsCount: nil

    ),
    ImagesGridViewItem.ViewModel(
      imageId: "2",
      isFavourite: true,
      imageTitle: nil,
      imageDescription: "image",
      imageUrl: "image",
      imageWidth: nil,
      imageHeight: nil,
      imageSize: nil,
      imageViewsCount: nil
    )
  ]
  viewModel.imagesGridViewModel.images = images
  return FavouriteImagesView(viewModel: viewModel)
}
