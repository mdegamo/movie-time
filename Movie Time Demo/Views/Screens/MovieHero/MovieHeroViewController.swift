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
    
    @IBOutlet weak var mainScrollView: UIScrollView! {
        didSet {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        }
    }
    
    @IBOutlet weak var dismissButton: UIButton! {
        didSet {
            dismissButton.layer.cornerRadius = CGFloat(16)
            dismissButton.clipsToBounds = true
            dismissButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        }
    }
    
    @IBOutlet weak var backgroundImage: UIImageView! {
        didSet {
            backgroundImage.backgroundColor = .darkGray
            backgroundImage.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var artworkImage: UIImageView! {
        didSet {
            artworkImage.contentMode = .scaleAspectFit
            artworkImage.clipsToBounds = false
            artworkImage.layer.shadowColor = UIColor.black.cgColor
            artworkImage.layer.shadowOpacity = 1
            artworkImage.layer.shadowOffset = .zero
            artworkImage.layer.shadowRadius = 10
        }
    }
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.color = .white
        }
    }
    
    @IBOutlet weak var priceLabelContainer: UIView!{
        didSet {
            priceLabelContainer.backgroundColor = .white
            priceLabelContainer.layer.cornerRadius = CGFloat(20)
            priceLabelContainer.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = .boldSystemFont(ofSize: 18)
            priceLabel.textColor = .blue
            priceLabel.textAlignment = .center
        }
    }
    
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.layer.cornerRadius = CGFloat(20)
            favoriteButton.clipsToBounds = true
            favoriteButton.backgroundColor = .white
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .boldSystemFont(ofSize: 32)
            titleLabel.numberOfLines = 0
        }
    }

    @IBOutlet weak var artistLabel: UILabel! {
        didSet {
            artistLabel.font = .systemFont(ofSize: 18)
        }
    }

    @IBOutlet weak var genreNameLabel: UILabel! {
        didSet {
            genreNameLabel.font = .boldSystemFont(ofSize: 14)
            genreNameLabel.textColor = .gray
            genreNameLabel.text = R.string.localizable.genre()
        }
    }
    
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            genreLabel.font = .systemFont(ofSize: 18)
        }
    }
    
    @IBOutlet weak var longDescriptionNameLabel: UILabel! {
        didSet {
            longDescriptionNameLabel.font = .boldSystemFont(ofSize: 14)
            longDescriptionNameLabel.textColor = .gray
            longDescriptionNameLabel.text = R.string.localizable.description()
        }
    }
    
    @IBOutlet weak var longDescriptionLabel: UILabel! {
        didSet {
            longDescriptionLabel.numberOfLines = 0
            longDescriptionLabel.font = .systemFont(ofSize: 18)
        }
    }
    
    
    // MARK: Actions
    
    @IBAction func didTapDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        favoriteButton.isEnabled = false
        
        if let trackId = viewModel.data.id {
            if FavoriteStore.getFavorites().contains(trackId) {
                if FavoriteStore.removeFromFavorites(trackId) {
                    favoriteButton.backgroundColor = .white
                } else {
                    favoriteButton.backgroundColor = .red
                }
            } else {
                if FavoriteStore.addToFavorites(trackId) {
                    favoriteButton.backgroundColor = .red
                } else {
                    favoriteButton.backgroundColor = .white
                }
            }
        }
        
        favoriteButton.isEnabled = true
    }
    
    
    // MARK: Overrides
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        initViewController()
    }
    
}


extension MovieHeroViewController {
    
    // MARK: Setup & Initialization
    
    func setupViews() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backgroundImage.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.9
        backgroundImage.addSubview(blurEffectView)
    }
    
    func initViewController() {
        if let price = viewModel.data.price {
            priceLabel.text = R.string.localizable.priceFormat(Double(price))
        }
        titleLabel.text = viewModel.data.title
        artistLabel.text = viewModel.data.artist
        genreLabel.text = viewModel.data.genre
        longDescriptionLabel.text = viewModel.data.longDescription
        
        if let trackId = viewModel.data.id,
            FavoriteStore.getFavorites().contains(trackId) {
            favoriteButton.backgroundColor = .red
        }
        
        loadArtwork()
    }
    
    
    // MARK: Methods
    
    func loadArtwork() {
        activityIndicatorView.startAnimating()
        
        // We know that thumbnail is/might already being cached, so we load it first
        // to avoid the blank state.
        RestApi.shared.getThumbnail(
            for: viewModel.data,
            onSuccess: { image in
                self.artworkImage.image = image
                self.backgroundImage.image = image
            })
        
        RestApi.shared.getLargeArtwork(
            for: viewModel.data,
            onSuccess: { image in
                self.activityIndicatorView.stopAnimating()
                self.artworkImage.image = image
                self.backgroundImage.image = image
            },
            onError: { _ in
                self.activityIndicatorView.stopAnimating()
                #warning("Load placeholder image")
            })
    }
    
}
