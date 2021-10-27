//
//  RatingView.swift
//  CS_iOS_Assignment
//
//  Copyright © 2019 longtranz. All rights reserved.
//

import UIKit

class RatingView: UIView {
    private var ratingLabel: UILabel!
    private var progressBar: CircleProgressBarView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubviews()
    }
    
    func initSubviews() {
        self.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.1019607843, blue: 0.1294117647, alpha: 1)
        self.layer.cornerRadius = self.frame.height / 2
        
        ratingLabel = UILabel(frame: CGRect(x: 3,
                                            y: 3,
                                            width: self.frame.width - 6,
                                            height: self.frame.height - 6))
        ratingLabel.layer.cornerRadius = ratingLabel.frame.height / 2
        ratingLabel.layer.masksToBounds = true
        ratingLabel.textAlignment = .center
        ratingLabel.textColor = .white
        self.addSubview(ratingLabel)
                
        ratingLabel.text = "80%"
        
        initProgressView()
    }
    
    private func initProgressView() {
        progressBar = CircleProgressBarView(frame: CGRect(x: 2,
                                                          y: 2,
                                                          width: self.frame.width - 4,
                                                          height: self.frame.height - 4))
        self.addSubview(progressBar)
    }
        
    
    func setRating(rating: Double) {
        let rate = round(rating)
        
        ratingLabel.attributedText = getRatingString(rating: rate)
        
        progressBar.setValue(value: rate)
    }
    
    private func getRatingString(rating: Double) -> NSAttributedString {
        let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)
        ]
        let ratingAttrString = NSMutableAttributedString(string: rating > 0 ? String(format: "%.0f%%", rating) : "-",
                                                  attributes: attributes)
        
        if rating > 0 {
            let subscriptionAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 6),
                NSAttributedString.Key.baselineOffset: 5
            ]
            ratingAttrString.setAttributes(subscriptionAttributes, range: NSRange(location: ratingAttrString.length - 1, length: 1))
        }
        
        return ratingAttrString
    }
}
