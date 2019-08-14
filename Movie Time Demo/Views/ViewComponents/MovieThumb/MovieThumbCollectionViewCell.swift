//
//  MovieListThumbCollectionViewCell.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieThumbsCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var thumbView: MovieThumbView!
    
    var data: MovieResponseModel! {
        didSet {
            if let price = data.price {
                thumbView.priceLabel.text = R.string.localizable.priceFormat(Double(price))
            }
            
            thumbView.titleLabel.text = data.title
            thumbView.artistLabel.text = data.artist
        }
    }
    
    
    // MARK: Setup & Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        thumbView = MovieThumbView(frame: .zero)
        
        addSubview(thumbView)
        thumbView.translatesAutoresizingMaskIntoConstraints = false
        thumbView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        thumbView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        thumbView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        thumbView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
