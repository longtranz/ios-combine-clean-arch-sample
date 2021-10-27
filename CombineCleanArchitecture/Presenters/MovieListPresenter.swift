//
//  MovieListPresenter.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieListPresenterProtocol {
    var viewModel: MovieListViewModel { get }
    var currentPage: Int { get }
    
    init(view: MovieListViewProtocol?)
    
    func refreshMovies(movies: [MovieListModel.MovieListEntity], totalPage: Int)
    func updateMovies(movies: [MovieListModel.MovieListEntity], currentPage: Int, totalPage: Int)
}

class MovieListPresenter: MovieListPresenterProtocol {
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    var currentPage: Int { viewModel.page }
    
    private var view: MovieListViewProtocol?
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(view: MovieListViewProtocol?) {
        self.view = view
        
        setupData()
    }
    
    private func setupData() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] results in
                guard let strongSelf = self else { return }
                
                strongSelf.view?.updateList()
            }
            .store(in: &cancellable)
    }
    
    func refreshMovies(movies: [MovieListModel.MovieListEntity], totalPage: Int) {
        viewModel.movies = transformToViewModels(movieListEntities: movies)
        
        viewModel.page = 1
        viewModel.totalPage = totalPage
    }
    
    func updateMovies(movies: [MovieListModel.MovieListEntity], currentPage: Int, totalPage: Int) {
        let movieViewModelList = transformToViewModels(movieListEntities: movies)
        viewModel.movies.append(contentsOf: movieViewModelList)
        
        viewModel.page = currentPage + 1
        viewModel.totalPage = totalPage
    }
    
    private func transformToViewModels(movieListEntities: [MovieListModel.MovieListEntity]) -> [MovieListModel.MovieViewModel] {
        return movieListEntities.compactMap { MovieListModel.MovieViewModel(from: $0) }
    }
}

