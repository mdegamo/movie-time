//
//  ViewController.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: Properties
    
    let viewModel = MovieListViewModel()
    
    
    // MARK: Outlets
    
    @IBOutlet weak var mainTableView: MovieListTableView!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
        didSet {
            activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.stopAnimating()
        }
    }
    
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.textAlignment = .center
            loadingLabel.text = R.string.localizable.fetchingMovies()
            loadingLabel.isHidden = true
        }
    }
    
    
    // MARK: Overrides
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let receiver = segue.destination as? MovieCollectionListViewController,
            let data = sender as? MoviesCollectionDisplayModel {
            receiver.viewModel.data = data
        } else if let receiver = segue.destination as? MovieHeroViewController,
            let data = sender as? MovieResponseModel {
            receiver.viewModel.data = data
        }
    }
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViewController()
        refreshTableView()
        setupNotificationObservers()
    }

}


extension MovieListViewController {
    
    // MARK: Setup & Initialization
    
    func initViewController() {
        self.navigationItem.title = AppConfig.name
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: R.string.localizable.back(),
            style: .plain,
            target: nil,
            action: nil)
        if let navBar = self.navigationController?.navigationBar {
            navBar.prefersLargeTitles = true
            navBar.barTintColor = .white
            navBar.shadowImage = UIImage()
        }
        mainTableView.actionsDelegate = self
        mainTableView.renderDelegate = self
    }
    
    func setupNotificationObservers() {
        let center = NotificationCenter.default
        
        center.addObserver(
            self,
            selector: #selector(didReceiveUpdateFavorites(notification:)),
            name: Notification.Name(rawValue: ObserverNotificationKeys.didUpdateFavoritesKey),
            object: nil)
    }
        
        
    // MARK: Methods
    
    @objc func didReceiveUpdateFavorites(notification: NSNotification) {
        refreshTableView()
    }
    
    func refreshTableView() {
        displayAsLoading(true)
        viewModel.fetchMovies(onSuccess: { movieCollection in
            self.mainTableView.data = movieCollection
            self.mainTableView.reloadData()
            self.displayAsLoading(false)
        }, onError: { error in
            self.displayAsLoading(false)
            
            let alert = UIAlertController(
                title: R.string.localizable.error(),
                message: R.string.localizable.fetchingMoviesErrorMessage(),
                preferredStyle: .alert)
            let action = UIAlertAction(
                title: R.string.localizable.tryAgain(),
                style: .default,
                handler: { _ in
                    alert.dismiss(animated: true, completion: {
                        self.refreshTableView()
                    })
                })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func displayAsLoading(_ flag: Bool) {
        if flag {
            activityIndicatorView.startAnimating()
            loadingLabel.isHidden = false
            mainTableView.isHidden = true
        } else {
            activityIndicatorView.stopAnimating()
            loadingLabel.isHidden = true
            mainTableView.isHidden = false
        }
    }
    
}


extension MovieListViewController: MovieListTableViewActionsDelegate {
    
    func didEmitViewAllAction(moviesCollection: MoviesCollectionDisplayModel) {
        performSegue(withIdentifier: R.segue.movieListViewController.movieListToMovieCollectionSegueIdentifier.identifier, sender: moviesCollection)
    }
    
    func didSelectMovie(movie: MovieResponseModel) {
        performSegue(withIdentifier: R.segue.movieListViewController.movieListToMovieHeroSegueIdentifier.identifier, sender: movie)
    }
    
}


extension MovieListViewController: MovieListTableViewRenderDelegate {
    
    func didRenderThumb(cell: MovieThumbsCollectionViewCell, movie: MovieResponseModel) {
        loadThumbImage(cell: cell, movie: movie)
    }
    
}
