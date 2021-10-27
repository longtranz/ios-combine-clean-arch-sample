//
//  NowPlayingTableViewCell.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/3/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import UIKit

protocol NowPlayingViewProtocol {
    func updateNowPlayingList()
}

protocol NowPlayingTableViewCellDelegate {
    func didSelectNowPlayingMovie(with id: Int)
}

class NowPlayingTableViewCell: UITableViewCell, NowPlayingViewProtocol {
    @IBOutlet private var nowPlayingCollectionView: UICollectionView!
    
    static let nowPlayingCollectionCellIdentifier = "NowPlayingCollectionCell"
    
    var nowPlayingPresenter: MovieNowPlayingListPresenterProtocol!
    var nowPlayingInteractor: MovieNowPlayingInteractorProtocol!
    
    var delegate: NowPlayingTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        nowPlayingPresenter = MovieNowPlayingListPresenter(view: self)
        nowPlayingInteractor = MovieNowPlayingInteractor(presenter: nowPlayingPresenter,
                                                         repository: MovieRepository())
        initView()
        nowPlayingInteractor.fetchMovies(page: 1)
    }
    
    private func initView() {
        nowPlayingCollectionView.showsHorizontalScrollIndicator = false
        nowPlayingCollectionView.backgroundColor = AppConstants.Color.mainBackground
    }
    
    func updateNowPlayingList() {
        nowPlayingCollectionView.reloadData()
    }
}

extension NowPlayingTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = nowPlayingInteractor.getMovieAt(indexPath.row)
        
        if let movieId = movie.id {
            delegate?.didSelectNowPlayingMovie(with: movieId)
        }
    }
}

extension NowPlayingTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let nowPlayingCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingTableViewCell.nowPlayingCollectionCellIdentifier,
                                           for: indexPath) as! NowPlayingCollectionCell & NowPlayingCellProtocol
        let movie = nowPlayingInteractor.getMovieAt(indexPath.row)
        nowPlayingCollectionCell.configure(movie: movie)
        return nowPlayingCollectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingPresenter.viewModel.movies.count
    }
}

extension NowPlayingTableViewCell: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 106, height: 160)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
