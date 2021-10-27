//
//  MovieListInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/2/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

enum MovieListState {
    case loading
    case success
    case fail
}

protocol MovieListInteractorProtocol: BaseMovieListInteractorProtocol {
    var currentPage: Int { get }
    
    init(presenter: MovieListPresenterProtocol, movieWebRepository: MovieRepositoryProtocol)
}

class MovieListInteractor: MovieListInteractorProtocol {
    var currentPage: Int { movieListPresenter.currentPage }
    
    private(set) var totalPages: Int = 0

    private var movieListPresenter: MovieListPresenterProtocol
    
    private var movieWebRepository: MovieRepositoryProtocol
    
    @Published private(set) var movies: [MovieListModel.MovieListEntity] = []
    
    var moviesPublisher: Published<[MovieListModel.MovieListEntity]>.Publisher { $movies }
    
    private var cancellable = Set<AnyCancellable>()
    
    required init(presenter: MovieListPresenterProtocol, movieWebRepository: MovieRepositoryProtocol) {
        self.movieListPresenter = presenter
        self.movieWebRepository = movieWebRepository
    }
    
    func fetchMovies(page: Int) {
        
        movieWebRepository.fetchMovies(page: page)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let strongSelf = self else {
                    return
                }
                
                if let movieResults = response.results {
                    strongSelf.movies.append(contentsOf: movieResults)
                                        
                    strongSelf.totalPages = response.totalPages ?? strongSelf.totalPages
                    strongSelf.movieListPresenter.updateMovies(movies: movieResults,
                                                               currentPage: response.page ?? strongSelf.currentPage,
                                                               totalPage: strongSelf.totalPages)
                }
            }
            .store(in: &cancellable)
    }
    
    func refreshMovies() {
        movieWebRepository.fetchMovies(page: 1)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else {
                    return
                }
                
                if let movieResults = response.results, let totalPage = response.totalPages {
                    self.movies = movieResults
                    
                    self.movieListPresenter.refreshMovies(movies: movieResults,
                                                          totalPage: totalPage)
                }
            }
            .store(in: &cancellable)
    }
    
    func getMovieAt(_ index: Int) -> MovieListModel.MovieListEntity {
        return movies[index]
    }
}
