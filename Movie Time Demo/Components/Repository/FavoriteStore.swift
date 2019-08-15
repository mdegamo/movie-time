//
//  FavoriteStore.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 15/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Foundation


/// UserDefaults wrapper for persisting movies that are "favorited" by the user.
struct FavoriteStore {
    
    private static let movieIdKey = "\(AppConfig.identity).UserDefaults.FavoriteStore.favoriteMovie"
    
    /// Get a list of movies "favorited" by the user.
    ///
    /// - Returns: An array of `TrackId`
    static func getFavorites() -> [TrackId] {
        return (UserDefaults.standard.array(forKey: movieIdKey) as? [TrackId]) ?? [TrackId]()
    }
    
    /// Adds a movie to "Favorites".
    ///
    /// - Parameter id: The movie `id`
    /// - Returns: returns `true` if successful `false` otherwise
    static func addToFavorites(_ id: TrackId) -> Bool {
        var favorites = getFavorites()
        
        if !favorites.contains(id) {
            favorites.append(id)
            UserDefaults.standard.set(favorites, forKey: movieIdKey)
            UserDefaults.standard.synchronize()
            emitUpdateNotification()
            
            return true
        }
        
        return false
    }
    
    /// Removes a movie from "Favorites".
    ///
    /// - Parameter id: The movie `id`
    /// - Returns: returns `true` if successful `false` otherwise
    static func removeFromFavorites(_ id: TrackId) -> Bool {
        let favorites = getFavorites()
        
        if favorites.contains(id) {
            let newFavorites = favorites.filter { $0 != id }
            UserDefaults.standard.set(newFavorites, forKey: movieIdKey)
            UserDefaults.standard.synchronize()
            emitUpdateNotification()
            
            return true
        }
        
        return false
    }

    private static func emitUpdateNotification() {
        NotificationCenter.default.post(
            name: NSNotification.Name(rawValue: ObserverNotificationKeys.didUpdateFavoritesKey),
            object: nil,
            userInfo: nil)
    }
    
}
