//
//  AppConfig.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Foundation

struct AppConfig {
    
    // The maximum number of thumbnails to show on a single line collection
    static let maxThumbPerCollection = 10
    
    // I usually pull the values of these structs from `Bundle.main` which varies
    // per build config, but for this demo I just hardcoded them.
    
    static let name = Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    
    static let identity = Bundle.main.bundleIdentifier ?? "com.mdegamo.Movie-Time-Demo"
    
    struct Api {
        static let baseUrl = "https://itunes.apple.com"
        static let baseSearchUrl = "\(baseUrl)/search"
        static let baseLookupUrl = "\(baseUrl)/lookup"
    }
    
    struct Security {
        // This is always true here but idealy this must be set to false on production.
        static let isLoggingEnabled = true
    }
}
