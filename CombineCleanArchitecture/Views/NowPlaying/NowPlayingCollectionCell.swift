//
//  NowPlayingCollectionCell.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import UIKit
import Kingfisher

protocol NowPlayingCellProtocol {
    func configure(movie: MovieListModel.MovieListEntity)
    func updateMovie(with movie: MovieListModel.MovieViewModel)
}

class NowPlayingCollectionCell: UICollectionViewCell, NowPlayingCellProtocol {
    @IBOutlet private var posterImageView: UIImageView!
    
    private var movieNowPlayingPresenter: MovieNowPlayingCellPresenterProtocol!
    private var movieNowPlayingInteractor: MovieNowPlayingCellInteractorProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        movieNowPlayingPresenter = MovieNowPlayingCellPresenter(view: self)
        movieNowPlayingInteractor = MovieNowPlayingCellInteractor(presenter: movieNowPlayingPresenter,
                                                                  repository: MovieRepository())

        initView()
    }

    func initView() {
        posterImageView.layer.cornerRadius = 20
        posterImageView.addShadow(offset: CGSize(width: 1, height: 3), color: .black, radius: 2.0, opacity: 0.7)
    }
    
    func configure(movie: MovieListModel.MovieListEntity) {
        movieNowPlayingInteractor.loadMovie(movie)
    }
    
    func updateMovie(with movie: MovieListModel.MovieViewModel) {
        guard let posterPath = movie.posterPath,
              let posterUrl = URL(string: posterPath) else { return }
        posterImageView.contentMode = ContentMode.scaleAspectFit
        posterImageView.kf.setImage(with: posterUrl, placeholder: nil, options: nil, completionHandler: nil)
    }
}
