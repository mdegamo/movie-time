//
//  MovieListTableView.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieListTableView: UITableView {
    
    // Properties
    
    var data = [MoviesCollectionDisplayModel]()
    
    
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
        Log.debug("XX Data Count", data.count)
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = R.reuseIdentifier.movieListItemCellIdentifier.identifier
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MovieListTableViewCell
        
        if let cellData = data[safe: indexPath.item] {
            cell.data = cellData
        }
        
        return cell
    }
    
}
