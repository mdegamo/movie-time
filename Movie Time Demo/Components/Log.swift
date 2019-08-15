//
//  Log.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//



/// A simple utility for logging.
struct Log {
    
    // MARK: Common logging functions
    
    // These functions only logs on debug builds to avoid unintentional logs
    // for production builds. Also see `AppConfig.swift` for additional details.
    
    static func debug(_ items: Any...) {
        if AppConfig.Security.isLoggingEnabled {
            print("DEBUG", items)
        }
    }
    
    static func info(_ items: Any...) {
        if AppConfig.Security.isLoggingEnabled {
            print("INFO", items)
        }
    }
    
    static func warning(_ items: Any...) {
        if AppConfig.Security.isLoggingEnabled {
            print("WARNING", items)
        }
    }
    
    
    // MARK: Error logging functions
    
    // Errors are always logged. I normally use Crashlytic's `CLSNSLogv` function,
    // but for this demo, I just use `print`
    
    static func error(_ items: Any...) {
        print("ERROR", items)
    }
    
    static func severe(_ items: Any...) {
        print("SEVERE", items)
    }
    
}
