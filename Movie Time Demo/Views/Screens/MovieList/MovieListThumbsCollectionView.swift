//
//  MovieListThumbsCollectionView.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

protocol MovieListThumbsActionsDelegate {
    func didSelectMovie(movie: MovieResponseModel)
}

protocol MovieListThumbsRenderDelegate: MovieThumbsCollectionViewCellRenderDelegate {}


class MovieListThumbsCollectionView: UICollectionView {
    
    // MARK: Properties
    
    var data: [MovieResponseModel]!
    
    var actionsDelegate: MovieListThumbsActionsDelegate?
    
    var renderDelegate: MovieListThumbsRenderDelegate?
    
    // MARK: Setup & Initialization
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        backgroundColor = .clear
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        dataSource = self
        delegate = self
    }
}


extension MovieListThumbsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let max = AppConfig.maxThumbPerCollection
        return data.count > max ? max : data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = R.reuseIdentifier.movieListThumbCellIdentifier.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieThumbsCollectionViewCell

        if let cellData = data[safe: indexPath.item] {
            cell.data = cellData
            renderDelegate?.didRenderThumb(cell: cell, movie: cellData)
        }
        
        return cell
    }
    
}


extension MovieListThumbsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let movie = data[safe: indexPath.item] {
            actionsDelegate?.didSelectMovie(movie: movie)
        }
    }
    
}


extension MovieListThumbsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(10)
    }
    
}
