//
//  MovieCollectionCollectionView.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 14/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

protocol MovieCollectionActionsDelegate {
    func didSelectMovie(movie: MovieResponseModel)
}


class MovieCollectionCollectionView: UICollectionView {
    
    // MARK: Properties
    
    var data: [MovieResponseModel]!
    
    var actionsDelegate: MovieCollectionActionsDelegate?
    
    let padding = CGFloat(16)
    
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
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        contentInset = UIEdgeInsets(top: padding * 2, left: padding, bottom: padding * 2, right: padding)
        dataSource = self
        delegate = self
    }
    
}



extension MovieCollectionCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellIdentifier = R.reuseIdentifier.movieCollectionThumbCellIdentifier.identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieThumbsCollectionViewCell
        
        if let cellData = data[safe: indexPath.item] {
            cell.data = cellData
        }
        
        return cell
    }
    
}


extension MovieCollectionCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        if let movie = data[safe: indexPath.item] {
            actionsDelegate?.didSelectMovie(movie: movie)
        }
    }
    
}


extension MovieCollectionCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let heightAddOn = CGFloat(50)
        
        Log.debug("XX Screen Width: \(collectionView.frame.size.width)")
        
        func calcWidth(byItemCount count: Int) -> CGFloat {
            let divisor = CGFloat(count)
            let sidePadding = padding * 2
            let totalGaps = padding * (divisor - 1)
            let availableScreenWidth = (collectionView.frame.size.width - (sidePadding + totalGaps))
            return availableScreenWidth / divisor
        }
        
        var width = calcWidth(byItemCount: 2)
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            width = calcWidth(byItemCount: 4)
            
            if UIDevice.current.orientation.isLandscape {
                width = calcWidth(byItemCount: 6)
            }
        } else {
            if UIDevice.current.orientation.isLandscape {
                width = calcWidth(byItemCount: 3)
            }
        }
        
        return CGSize(width: width, height: width + heightAddOn)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return padding
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return padding * 2
    }
    
}
