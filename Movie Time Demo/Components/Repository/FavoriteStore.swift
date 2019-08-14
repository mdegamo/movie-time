//
//  FavoriteStore.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 15/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Foundation

struct FavoriteStore {
    
    private static let movieIdKey = "\(AppConfig.identity).UserDefaults.FavoriteStore.favoriteMovie"
    
    static func getFavorites() -> [TrackId] {
        return (UserDefaults.standard.array(forKey: movieIdKey) as? [TrackId]) ?? [TrackId]()
    }
    
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
