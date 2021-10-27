//
//  MovieNowPlayingCellInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation

protocol MovieNowPlayingCellInteractorProtocol {
    init(presenter: MovieNowPlayingCellPresenterProtocol, repository: MovieRepositoryProtocol)
    
    func loadMovie(_ movie: MovieListModel.MovieListEntity)
}

class MovieNowPlayingCellInteractor: MovieNowPlayingCellInteractorProtocol {
    private var presenter: MovieNowPlayingCellPresenterProtocol
    private var movieRepository: MovieRepositoryProtocol
    
    required init(presenter: MovieNowPlayingCellPresenterProtocol, repository: MovieRepositoryProtocol) {
        self.presenter = presenter
        self.movieRepository = repository
    }
    
    func loadMovie(_ movie: MovieListModel.MovieListEntity) {
        presenter.updateMovie(movie: movie)
    }
}
