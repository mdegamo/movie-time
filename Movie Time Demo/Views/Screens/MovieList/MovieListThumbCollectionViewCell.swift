//
//  MovieListThumbCollectionViewCell.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieListThumbsCollectionViewCell: UICollectionViewCell {
    
    // MARK: Properties
    
    var data: MovieResponseModel! {
        didSet {
            if let price = data.price {
                thumbView.priceLabel.text = R.string.localizable.priceFormat(Double(price))
            }
            
            thumbView.titleLabel.text = data.title
            thumbView.artistLabel.text = data.artist
        }
    }
    
    
    // MARK: Outlets
    
    @IBOutlet weak var thumbView: MovieThumbView!
    
    
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
        
    }
}
