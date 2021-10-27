//
//  MovieListViewModel.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

class MovieListViewModel {
    @Published var movies: [MovieListModel.MovieViewModel] = []
    var page: Int = 1
    var totalPage: Int = 1
}
