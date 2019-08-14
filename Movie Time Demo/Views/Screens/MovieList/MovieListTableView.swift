//
//  MovieListTableView.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

protocol MovieListTableViewActionsDelegate: MovieListTableViewCellActionsDelegate {}

protocol MovieListTableViewRenderDelegate: MovieListTableViewCellRenderDelegate {}


class MovieListTableView: UITableView {
    
    // Properties
    
    var data = [MoviesCollectionDisplayModel]()
    
    var actionsDelegate: MovieListTableViewActionsDelegate?
    
    var renderDelegate: MovieListTableViewRenderDelegate?
    
    
    // MARK: Setup & Initialization
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        dataSource = self
        separatorStyle = .none
        allowsSelection = false
    }

}


extension MovieListTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = R.reuseIdentifier.movieListItemCellIdentifier.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MovieListTableViewCell
        
        if let cellData = data[safe: indexPath.item] {
            cell.data = cellData
            cell.actionsDelegate = self
            cell.renderDelegate = self
        }
        
        return cell
    }
    
}


extension MovieListTableView: MovieListTableViewCellActionsDelegate {
    
    func didEmitViewAllAction(moviesCollection: MoviesCollectionDisplayModel) {
        actionsDelegate?.didEmitViewAllAction(moviesCollection: moviesCollection)
    }
    
    func didSelectMovie(movie: MovieResponseModel) {
        actionsDelegate?.didSelectMovie(movie: movie)
    }
    
}


extension MovieListTableView: MovieListTableViewRenderDelegate {
    
    func didRenderThumb(cell: MovieThumbsCollectionViewCell, movie: MovieResponseModel) {
        renderDelegate?.didRenderThumb(cell: cell, movie: movie)
    }
    
}
