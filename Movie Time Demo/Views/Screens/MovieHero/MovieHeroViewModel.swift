//
//  MovieHeroViewModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 14/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

class MovieHeroViewModel {
    
    // Properties
    
    var data: MovieResponseModel!
    
    var isFavorited: Bool {
        if let trackId = data.id,
            FavoriteStore.getFavorites().contains(trackId) {
            return true
        }
        
        return false
    }
    
}
