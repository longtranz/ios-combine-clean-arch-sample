//
//  MovieDetailViewController.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieDetailViewControllerProtocol {
    func updateView(with movie: MovieModel.MovieViewModel)
}

class MovieDetailViewController: UIViewController, MovieDetailViewControllerProtocol {

    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var releaseDurationLabel: UILabel!
    @IBOutlet private weak var overviewLabel: UILabel!
    @IBOutlet private weak var genreListView: GenreListView!
    
    private var movieDetailRouter: MovieDetailRouterProtocol!
    private var movieDetailInteractor: MovieDetailInteractorProtocol?
    private var movieId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        movieDetailRouter = MovieDetailRouter(viewController: self)
        movieDetailInteractor = MovieDetailInteractor(presenter: MovieDetailPresenter(view: self),
                                                      repository: MovieRepository())
        
        setupView()
        
        if let movieId = movieId {
            movieDetailInteractor?.loadMovie(id: movieId)
        }
    }
    
    private func setupView() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.borderWidth = 2
        posterImageView.layer.borderColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1).cgColor
        
        closeButton.setImage(UIImage(named: AppConstants.Image.movieDetailCloseIcon)?.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.imageView?.tintColor = .white
        
        self.view.layer.opacity = 0.9
    }
    
    func setupMovie(id: Int) {
        movieId = id
    }
    
    func updateView(with movie: MovieModel.MovieViewModel) {
        titleLabel.text = movie.title
        overviewLabel.text = movie.overview
        
        let genres: [String] = movie.genres?.compactMap { $0.name?.uppercased() } ?? []
        genreListView.updateGenres(genres)
        
        if let releaseDate = movie.releaseDate?.toString(format: AppConstants.DateFormat.MMMMDDYYYY),
           let duration = movie.duration {
            releaseDurationLabel.text = String(format: "%@ - %@", releaseDate, duration)
        }
        
        if let posterPath = movie.posterPath,
           let posterUrl = URL(string: posterPath) {
            posterImageView.kf.setImage(with: posterUrl, placeholder: nil, options: nil, completionHandler: nil)
        }
    }
    
    @IBAction func onClose() {
        movieDetailRouter.onClose()
    }
}
