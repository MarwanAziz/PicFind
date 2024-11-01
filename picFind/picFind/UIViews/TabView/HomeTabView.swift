//
//  HomeTabView.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import SwiftUI

struct HomeTabView: View {
  @State var selection = 0
    var body: some View {
      TabView(selection: $selection) {
        SearchTabView(viewModel: SearchTabView.ViewModel())
        FavouriteImagesView(viewModel: FavouriteImagesView.ViewModel())
      }
    }
}

#Preview {
    HomeTabView()
}
