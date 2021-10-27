//
//  MovieNowPlayingInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieNowPlayingInteractorProtocol: BaseMovieListInteractorProtocol {
    init(presenter: MovieNowPlayingListPresenterProtocol,
         repository: MovieRepositoryProtocol)
}

class MovieNowPlayingInteractor: MovieNowPlayingInteractorProtocol {
    
    private var presenter: MovieNowPlayingListPresenterProtocol
    private var movieRepository: MovieRepositoryProtocol
    
    @Published private(set) var movies: [MovieListModel.MovieListEntity] = []
    
    var moviesPublisher: Published<[MovieListModel.MovieListEntity]>.Publisher { $movies }
    
    private var combineCancellable = Set<AnyCancellable>()
    
    required init(presenter: MovieNowPlayingListPresenterProtocol, repository: MovieRepositoryProtocol) {
        self.presenter = presenter
        self.movieRepository = repository
    }
    
    func refreshMovies() {
        fetchMovies()
    }
    
    func fetchMovies(page: Int = 1) {
        movieRepository.fetchNowPlaying()
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
                
                if let movieResults = response.results {
                    self.movies = movieResults
                    self.presenter.updateMovies(movies: movieResults)
                }
            }
            .store(in: &combineCancellable)
    }
    
    func getMovieAt(_ index: Int) -> MovieListModel.MovieListEntity {
        return movies[index]
    }
}
