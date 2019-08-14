//
//  MovieListViewModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

class MovieListViewModel {
    
    let restApi = RestApi()
    
}


extension MovieListViewModel {
    
    func fetchMovies(onSuccess: @escaping ([MoviesCollectionDisplayModel]) -> Void,
                     onError: @escaping (WebServiceError) -> Void) {
        var collection = [MoviesCollectionDisplayModel]()
        
        restApi.getMovies(onSuccess: { movies in
            let favoriteMovies = self.getFavoriteMovies(movies)
            if favoriteMovies.movies.count > 0 {
               collection.append(favoriteMovies)
            }
            
            let featuredMovies = self.getFeaturedMovies(movies)
            collection.append(featuredMovies)
            
            let genreGroup = self.groupMoviesByGenre(movies)
            collection.append(contentsOf: genreGroup)
            
            onSuccess(collection)
        }, onError: onError)
    }
    
    func getFavoriteMovies(_ movies: [MovieResponseModel]) -> MoviesCollectionDisplayModel {
        #warning("Fetch favorites from coredata")
        var favoriteMovies = [MovieResponseModel]()
        
        return MoviesCollectionDisplayModel(collectionName: R.string.localizable.favorites(),
                                            movies: favoriteMovies)
    }
    
    func getFeaturedMovies(_ movies: [MovieResponseModel]) -> MoviesCollectionDisplayModel {
        var featuredMovies = [MovieResponseModel]()
        
        repeat {
            let index = Int.random(in: 0 ..< movies.count)
            let movie = movies[index]
            
            if !featuredMovies.contains(where: { $0.id == movie.id }) {
                featuredMovies.append(movie)
            }
        } while (featuredMovies.count < AppConfig.maxThumbPerCollection)
        
        return MoviesCollectionDisplayModel(collectionName: R.string.localizable.featured(),
                                            movies: featuredMovies)
    }
    
    func groupMoviesByGenre(_ movies: [MovieResponseModel]) -> [MoviesCollectionDisplayModel] {
        var collection = [MoviesCollectionDisplayModel]()
        
        for movie in movies {
            let genre = movie.genre ?? R.string.localizable.unknown()
            
            if let index = collection.firstIndex(where: { $0.collectionName == genre }) {
                collection[index].movies.append(movie)
            } else {
                let newCollection = MoviesCollectionDisplayModel(collectionName: genre, movies: [movie])
                collection.append(newCollection)
            }
        }
        
        return collection.sorted {
            $0.collectionName < $1.collectionName
        }
    }
    
}
