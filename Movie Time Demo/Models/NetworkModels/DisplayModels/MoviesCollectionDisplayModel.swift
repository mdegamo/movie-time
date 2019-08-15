//
//  MoviesCollectionDisplayModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 13/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//


/// This struct is used to represent a collection of movies group by
/// a common something, e.g. Genre
struct MoviesCollectionDisplayModel {
    var collectionName: String
    var movies: [MovieResponseModel]
}
