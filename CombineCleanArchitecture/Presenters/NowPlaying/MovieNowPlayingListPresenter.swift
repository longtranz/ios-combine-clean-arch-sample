//
//  MovieNowPlayingListPresenter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieNowPlayingListPresenterProtocol {
    var viewModel: MovieListViewModel { get set }
    
    init(view: NowPlayingViewProtocol?)
    func updateMovies(movies: [MovieListModel.MovieListEntity])
}

class MovieNowPlayingListPresenter: MovieNowPlayingListPresenterProtocol {
    var viewModel = MovieListViewModel()
    private var view: NowPlayingViewProtocol?
    private var cancellable = Set<AnyCancellable>()
    
    required init(view: NowPlayingViewProtocol?) {
        self.view = view
        
        setupData()
    }
    
    func setupData() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] movies in
                guard let self = self else { return }
                self.view?.updateNowPlayingList()
            }.store(in: &cancellable)
    }
    
    func updateMovies(movies: [MovieListModel.MovieListEntity]) {
        let movieModels = movies.compactMap { MovieListModel.MovieViewModel(from: $0) }
        
        viewModel.movies = movieModels
    }
}
