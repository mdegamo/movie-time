//
//  ObserverNotificationKeys.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 15/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//


/// This struct is just a centralized container of notification keys
struct ObserverNotificationKeys {
    
    /// Use this key to tell any observers that the FavoriteStore has been updated
    static let didUpdateFavoritesKey = "\(AppConfig.identity).ObserverNotificationKeys.didUpdateFavorites"
    
}
