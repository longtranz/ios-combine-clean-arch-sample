//
//  MovieDetailInteractor.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import Foundation
import Combine

protocol MovieDetailInteractorProtocol {
    var moviePublisher: Published<MovieModel.MovieEntity?>.Publisher { get }
    func loadMovie(id: Int)
    
    init(presenter: MovieDetailPresenterProtocol, repository: MovieRepositoryProtocol)
}

class MovieDetailInteractor: MovieDetailInteractorProtocol {
    private var presenter: MovieDetailPresenterProtocol
    private var repository: MovieRepositoryProtocol
    private var combineCancellable = Set<AnyCancellable>()
    
    @Published private var movie: MovieModel.MovieEntity?
    var moviePublisher: Published<MovieModel.MovieEntity?>.Publisher { $movie }
    
    required init(presenter: MovieDetailPresenterProtocol, repository: MovieRepositoryProtocol) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func loadMovie(id: Int) {
        repository.fetchMovie(id: id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] movieEntity in
                guard let self = self else { return }
                self.movie = movieEntity
                self.presenter.updateMovie(with: movieEntity)
            }
            .store(in: &combineCancellable)
    }
}
