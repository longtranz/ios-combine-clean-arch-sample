//
//  GenreCollectionViewCell.swift
//  CS_iOS_Assignment
//
//  Created by Tran Minh Long on 3/4/21.
//  Copyright © 2021 longtranz. All rights reserved.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreNameLabel: UILabel!
    
    static let identifier = "GenreCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        genreNameLabel.layer.masksToBounds = true
        genreNameLabel.layer.borderWidth = 1
        genreNameLabel.layer.cornerRadius = 5
        genreNameLabel.backgroundColor = .white
        genreNameLabel.textColor = .black
    }
    
    func setupGenre(_ name: String) {
        genreNameLabel.text = name
        genreNameLabel.sizeToFit()
    }
}
