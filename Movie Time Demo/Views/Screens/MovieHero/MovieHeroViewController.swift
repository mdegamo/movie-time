//
//  MovieHeroViewController.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 14/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieHeroViewController: UIViewController {
    
    // MARK: Properties
    
    var viewModel = MovieHeroViewModel()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var mainStackView: UIStackView!
    
    @IBOutlet weak var labelsStackView: UIStackView! {
        didSet {
            labelsStackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            labelsStackView.isLayoutMarginsRelativeArrangement = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .boldSystemFont(ofSize: 32)
            titleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var longDescriptionLabel: UILabel! {
        didSet {
            longDescriptionLabel.numberOfLines = 0
        }
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
}


extension MovieHeroViewController {
    
    // MARK: Setup & Initialization
    
    func initViewController() {
        titleLabel.text = viewModel.data.title
        artistLabel.text = viewModel.data.artist
        longDescriptionLabel.text = viewModel.data.longDescription
    }
    
}
