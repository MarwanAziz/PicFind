//
//  SearchTabView.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import SwiftUI

struct SearchTabView: View {
  @StateObject var viewModel: ViewModel
  @FocusState private var isSearchBarFocused: Bool

  var body: some View {
    NavigationSplitView {
      ImagesGridView(viewModel: viewModel.imagesGridViewModel)
        .padding(.horizontal, 8)
        .navigationTitle("Search photos")
        .toolbar {
          ToolbarItem(placement: .navigationBarLeading) {
            if viewModel.isSearching {
              ProgressView()
                .tint(.blue)
            }
          }
        }
        .navigationBarTitleDisplayMode(.inline)
        .searchable(
          text: $viewModel.search,
          placement: .navigationBarDrawer(displayMode: .automatic),
          suggestions:{
            if isSearchBarFocused {
              ForEach(viewModel.searchHistory, id: \.self) { search in
                HStack {
                  Image(systemName: "clock.arrow.circlepath")
                    .resizable()
                    .frame(width: 15, height: 15)
                  Text(search.searchTerm)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                  Spacer()
                }
                .frame(maxWidth: .infinity, idealHeight: 25)
                .contentShape(Rectangle())
                .onTapGesture {
                  isSearchBarFocused = false
                  viewModel.search = search.searchTerm
                  Task {
                    await viewModel.searchImages()
                  }
                }
              }
            } else {
              EmptyView()
            }
          }
        )
        .focused($isSearchBarFocused)
        .onSubmit(of: .search) {
          Task {
            await viewModel.searchImages()
          }
        }
    } detail: {}
      .focusable()
      .focused($isSearchBarFocused)
      .tabItem {
        Label("Search", systemImage: "magnifyingglass")
      }
  }
}

#Preview {
  let viewModel = SearchTabView.ViewModel()

  viewModel.imagesGridViewModel.images = [
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

  return SearchTabView(viewModel: viewModel)
}
