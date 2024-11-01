//
//  ImagesGridViewItem.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import SwiftUI

struct ImagesGridViewItem: View {
  @StateObject var viewModel: ViewModel
  @State private var loadingError = true

  private var errorView: some View {
    VStack {
      Text("🥴")
        .font(.largeTitle)
      Text("error")
        .foregroundColor(.secondary)
        .font(.footnote)
        .fontDesign(.rounded)
        .fontWeight(.thin)
    }
    .onAppear {
      loadingError = true
    }
  }

  private func imageView(_ geometry: GeometryProxy) -> some View {
    VStack {
      AsyncImage(url: viewModel.imageURL) { phase in
        switch phase {
        case .empty:
          ProgressView()
        case .success(let image):
          image
            .resizable()
            .onAppear {
              loadingError = false
            }
        case .failure:
          errorView
        @unknown default:
          errorView
        }
      }
      .aspectRatio(contentMode: .fill)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }

  private var topLayerViews: some View {
    VStack {
      HStack {
        Spacer()
        if !loadingError {
          Button(action: {
            viewModel.onFavouritedButtonTapped()
          }) {
            Image(systemName: viewModel.favouriteButtonImageName)
              .resizable()
              .scaledToFit()
              .frame(width: 15, height: 15)
          }
          .foregroundColor(.pink)
          .padding(6)
          .background(
            Circle()
              .fill(Color.white)
          )
          .frame(width: 50, height: 50)
        }
      }
      Spacer()
    }
  }

  var body: some View {
    NavigationLink(destination: ImageDetailsView(gridItemModel: viewModel)) {
      GeometryReader { geometry in
        ZStack {
          Color.gray.opacity(0.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .cornerRadius(12)
            .blur(radius: 2)
          imageView(geometry)
            .frame(width: geometry.size.width, height: geometry.size.width)
            .cornerRadius(12)
          topLayerViews
        }
      }
      .aspectRatio(1, contentMode: .fit)
    }
  }
}

#Preview {
  let viewModel = ImagesGridViewItem.ViewModel(
    imageId: "1",
    isFavourite: true,
    imageTitle: nil,
    imageDescription: "image",
    imageUrl: "image",
    imageWidth: nil,
    imageHeight: nil,
    imageSize: nil,
    imageViewsCount: nil
  )
  return ImagesGridViewItem(viewModel: viewModel)
}
