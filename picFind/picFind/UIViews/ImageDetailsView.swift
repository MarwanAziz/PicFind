//
//  ImageDetailsView.swift
//  picFind
//
//  Created by Marwan Aziz on 01/11/2024.
//

import SwiftUI

struct ImageDetailsView: View {
  let gridItemModel: ImagesGridViewItem.ViewModel
  @State private var currentZoom = 0.0
  @State private var totalZoom = 1.0

  var body: some View {
    GeometryReader { proxy in
      VStack {
        AsyncImage(url: gridItemModel.imageURL) { phase in
          switch phase {
          case .empty:
            ProgressView()
          case .success(let image):
            image
              .resizable()
              .scaledToFit()
              .scaleEffect(currentZoom + totalZoom)
              .gesture(
                MagnifyGesture()
                  .onChanged { value in
                    currentZoom = value.magnification - 1
                  }
                  .onEnded { value in
                    totalZoom += currentZoom
                    currentZoom = 0
                  }
              )
              .accessibilityZoomAction { action in
                if action.direction == .zoomIn {
                  totalZoom += 1
                } else {
                  totalZoom -= 1
                }
              }

          case .failure:
            Text("Failed to load image")
          @unknown default:
            EmptyView()
          }
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(Color.black)
      .edgesIgnoringSafeArea(.all)
      .navigationTitle("Image Viewer")
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  ImageDetailsView(gridItemModel: ImagesGridViewItem.ViewModel(
    imageId: "1",
    isFavourite: true,
    imageTitle: nil,
    imageDescription: "image",
    imageUrl: "https://i.imgur.com/E5gQmVS.jpg",
    imageWidth: nil,
    imageHeight: nil,
    imageSize: nil,
    imageViewsCount: nil
  ))
}
