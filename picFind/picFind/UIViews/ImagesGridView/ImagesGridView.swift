//
//  ImagesGridView.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import SwiftUI

struct ImagesGridView: View {
  @StateObject var viewModel: ViewModel
  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
    var body: some View {
      VStack {
        ScrollView {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.images, id: \.modelId) { image in
              ImagesGridViewItem(viewModel: image)
            }
          }
        }
      }.onAppear {
      }
    }
}

#Preview {
  let viewModel = ImagesGridView.ViewModel()
  viewModel.images = [
    ImagesGridViewItem.ViewModel(
      imageId: "1",
      isFavourite: true,
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
  return ImagesGridView(viewModel: viewModel)
}
