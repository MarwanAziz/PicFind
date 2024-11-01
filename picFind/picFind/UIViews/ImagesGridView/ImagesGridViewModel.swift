//
//  ImagesGridViewModel.swift
//  picFind
//
//  Created by Marwan Aziz on 31/10/2024.
//

import Foundation
import DataManager

extension ImagesGridView {
  class ViewModel: ObservableObject {
    @Published var images: [ImagesGridViewItem.ViewModel] = []
  }
}
