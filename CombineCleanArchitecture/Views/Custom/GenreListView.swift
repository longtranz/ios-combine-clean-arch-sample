//
//  GerneListView.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/4/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import UIKit

class GenreListView: UIView,
                     UICollectionViewDelegate,
                     UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout {
    @IBOutlet private weak var genreCollectionView: UICollectionView!
    
    private let GENRE_IDENTIFIER = "GenreCellIdentifier"
    
    private var genres: [String] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        nibSetup()
        setupView()
    }
    
    private func nibSetup() {
        let nib = UINib(nibName: "GenreListView", bundle: nil).instantiate(withOwner: self, options: nil)
        
        guard nib.count > 0,
              let contentView = nib[0] as? UIView else {
            return
        }
        contentView.backgroundColor = .clear
        self.addSubview(contentView)
        self.constrainToEdges(contentView)
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        genreCollectionView.backgroundColor = .clear
        genreCollectionView.register(UINib(nibName: GenreCollectionViewCell.identifier,
                                           bundle: Bundle.main),
                                     forCellWithReuseIdentifier: GENRE_IDENTIFIER)
    }
    
    func updateGenres(_ genres: [String]) {
        self.genres = genres
        
        genreCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GENRE_IDENTIFIER, for: indexPath) as? GenreCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let genre = genres[indexPath.row]
        
        cell.setupGenre(genre)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let genre = genres[indexPath.row]
        let stringSize = genre.size(withFont: UIFont.systemFont(ofSize: 14))
        
        return CGSize(width: stringSize.width + 10, height: 25)
    }
}
