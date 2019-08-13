//
//  MovieListTableViewCell.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var data: MoviesCollectionDisplayModel! {
        didSet {
            sectionTitleLabel.text = data.collectionName
            thumbsCollectionView.data = data.movies
            thumbsCollectionView.reloadData()
        }
    }
    
    
    // MARK: Outlets
    
    @IBOutlet weak var sectionTitleLabel: UILabel! {
        didSet {
            sectionTitleLabel.font = .boldSystemFont(ofSize: 18)
        }
    }
    
    @IBOutlet weak var viewAllButton: UIButton! {
        didSet {
            viewAllButton.setTitle(R.string.localizable.viewAll(), for: .normal)
            viewAllButton.titleLabel?.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        }
    }
    
    @IBOutlet weak var thumbsCollectionView: MovieListThumbsCollectionView!
    
    
    // MARK: Setup & Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
    }
}
