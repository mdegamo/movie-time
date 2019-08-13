//
//  MovieThumbView.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieThumbView: UIView {
    
    // MARK: Outlets
    
    @IBOutlet var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
        }
    }
    
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.layer.cornerRadius = CGFloat(15)
            thumbnailImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var priceLabelContainer: UIView! {
        didSet {
            priceLabelContainer.backgroundColor = .white
            priceLabelContainer.layer.cornerRadius = CGFloat(12)
            priceLabelContainer.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = .boldSystemFont(ofSize: 13)
            priceLabel.textColor = .blue
            priceLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 15)
        }
    }
    
    @IBOutlet weak var artistLabel: UILabel! {
        didSet {
            artistLabel.font = .systemFont(ofSize: 13)
            artistLabel.textColor = .gray
        }
    }
    
    
    // MARK: Setup & Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
        contentView?.prepareForInterfaceBuilder()
    }
    
}


extension MovieThumbView {
    
    // MARK: Setup & Initialization
    
    func setup() {
        setupXib()
    }
    
    func setupXib() {
        backgroundColor = .clear
        let view = initContentView(fromNibNamed: R.nib.movieThumbView.name)
        contentView = view
    }
    
}


extension MovieThumbView: XibLoadable {}
