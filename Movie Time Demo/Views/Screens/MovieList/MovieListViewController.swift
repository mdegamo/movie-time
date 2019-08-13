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
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
        refreshTableView()
    }

}


extension MovieListViewController {
    
    // MARK: Setup & Initialization
    
    func initViewController() {
        self.navigationItem.title = AppConfig.name
    }
    
    func refreshTableView() {
        viewModel.fetchMovies(onSuccess: { movieCollection in
            self.mainTableView.data = movieCollection
            self.mainTableView.reloadData()
        }, onError: { error in
            
        })
    }
    
}

