//
//  MovieCell.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 longtranz. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieCellProtocol {
    func setupData(movie: MovieListModel.MovieViewModel)
    func updateDuration(duration: String)
}

//
// MARK: - Movie Cell
//
class MovieCell: UITableViewCell, MovieCellProtocol {
    
    //
    // MARK: - Class Constants
    //
    static let identifier = "MovieCell"
    
    //
    // MARK: - IBOutlets
    //
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var rating: RatingView!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
    private var cellInteractor: MovieCellInteractorProtocol?
    
    func configure(movie: MovieListModel.MovieListEntity) {
        setupCell()
        
        if cellInteractor == nil {
            cellInteractor = MovieCellInteractor(presenter: MovieCellPresenter(cell: self),
                                                 repository: MovieRepository())
        }
        
        cellInteractor?.configure(with: movie)
    }
    
    private func setupCell() {
        poster.contentMode = .scaleAspectFill
        poster.layer.borderWidth = 1
        poster.layer.borderColor = #colorLiteral(red: 0.5098039216, green: 0.5098039216, blue: 0.5098039216, alpha: 1).cgColor
        self.bringSubviewToFront(rating)
    }
    
    func setupData(movie: MovieListModel.MovieViewModel) {
        title.text = movie.title
        releaseDate.text = movie.releaseDate?.toString(format: AppConstants.DateFormat.MMMMDDYYYY)
        durationLabel.text = movie.duration ?? "-"
        rating.setRating(rating: (movie.rating ?? 0) * 10)
        
        if let posterPath = movie.posterPath,
           let posterUrl = URL(string: posterPath) {
            poster.kf.setImage(with: posterUrl)
        }
    }
    
    func updateDuration(duration: String) {
        durationLabel.text = duration
    }
}
