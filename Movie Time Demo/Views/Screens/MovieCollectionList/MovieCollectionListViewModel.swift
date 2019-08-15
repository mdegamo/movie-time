//
//  MovieCollectionListViewModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 14/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

class MovieCollectionListViewModel {
    
    // MARK: Properties
    
    var data: MoviesCollectionDisplayModel!
    
    var hasFavorites: Bool {
        return FavoriteStore.getFavorites().count > 0
    }
    
}


extension MovieCollectionListViewModel {
    
    func refreshDataFromFavorites() {
        let favorites = FavoriteStore.getFavorites()
        let filteredMovies = data.movies.filter { favorites.contains($0.id ?? -9999) }
        let newData = MoviesCollectionDisplayModel(collectionName: data.collectionName, movies: filteredMovies)
        data = newData
    }
    
}
