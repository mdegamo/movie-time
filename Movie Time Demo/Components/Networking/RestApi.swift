//
//  RestApi.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit


/// This singleton struct handles the app's high-level networking logic.
///
/// Usage:
///
///     RestApi.shared.getMovies(...)
struct RestApi {
    
    static let shared = RestApi()
    
    private let webService: WebService
    
    private init() {
        webService = WebService()
    }
    
}

extension RestApi {
    
    
    /// Retrieves a list of movies from the iTunes Search API.
    ///
    /// - Parameters:
    ///   - onSuccess: A callback function when the request is successful.
    ///                 Returns an array of `MovieResponseModel` as the only argument.
    ///
    ///         onSuccess: { movies in
    ///             // do something with movies
    ///         }
    ///
    ///   - onError: A callback function when the request is not successful.
    ///                 Returns a `WebServiceError` as the only argument.
    ///
    ///         onError: { error in
    ///             // do something with error
    ///         }
    ///
    func getMovies(onSuccess: @escaping ([MovieResponseModel]) -> Void,
                   onError: @escaping (WebServiceError) -> Void) {
        webService.request(baseUrl: AppConfig.Api.baseSearchUrl,
                           parameters: [
                                "term" : "star",
                                "country" : "au",
                                "media" : "movie",
                                "all" : ""
                            ],
                           onSuccess: onSuccess,
                           onError: onError)
    }
    
    
    /// Gets the associated artwork of the movie.
    ///
    /// - Parameters:
    ///   - model: The movie as `MovieResponseModel`
    ///   - size: The desired image size.
    ///   - onSuccess: A callback function when the request is successful.
    ///                 Returns a `UIImage` as the only argument.
    ///
    ///         onSuccess: { image in
    ///             // do something with the image
    ///         }
    ///
    ///   - onError: A callback function when the request is not successful.
    ///                 Returns a `WebServiceError` as the only argument.
    ///
    ///         onError: { error in
    ///             // do something with error
    ///         }
    ///
    private func getImage(for model: MovieResponseModel,
                          withSize size: Int,
                          onSuccess: @escaping (UIImage) -> Void,
                          onError: ((WebServiceError) -> Void)? = nil) {
        if let url = model.artworkUrl {
            if let index = url.lastIndex(of: "/") {
                let betterThumbUrl = "\(url[..<index])/\(size)x\(size).jpg"
                webService.getImage(
                    from: betterThumbUrl,
                    onSuccess: onSuccess,
                    onError: { _ in
                        self.webService.getImage(from: url,
                                                 onSuccess: onSuccess,
                                                 onError: onError)
                })
            } else {
                webService.getImage(from: url,
                                    onSuccess: onSuccess,
                                    onError: onError)
            }
        }
    }
    
    /// Gets a 300x300 artwork image of the movie.
    ///
    /// - Parameters:
    ///   - model: The movie as `MovieResponseModel`
    ///   - onSuccess: A callback function when the request is successful.
    ///                 Returns a `UIImage` as the only argument.
    ///
    ///         onSuccess: { image in
    ///             // do something with the image
    ///         }
    ///
    ///   - onError: A callback function when the request is not successful.
    ///                 Returns a `WebServiceError` as the only argument.
    ///
    ///         onError: { error in
    ///             // do something with error
    ///         }
    ///
    func getThumbnail(for model: MovieResponseModel,
                      onSuccess: @escaping (UIImage) -> Void,
                      onError: ((WebServiceError) -> Void)? = nil) {
        getImage(for: model, withSize: 300, onSuccess: onSuccess, onError: onError)
    }
    
    /// Gets a 600x600 artwork image of the movie.
    ///
    /// - Parameters:
    ///   - model: The movie as `MovieResponseModel`
    ///   - onSuccess: A callback function when the request is successful.
    ///                 Returns a `UIImage` as the only argument.
    ///
    ///         onSuccess: { image in
    ///             // do something with the image
    ///         }
    ///
    ///   - onError: A callback function when the request is not successful.
    ///                 Returns a `WebServiceError` as the only argument.
    ///
    ///         onError: { error in
    ///             // do something with error
    ///         }
    ///
    func getLargeArtwork(for model: MovieResponseModel,
                         onSuccess: @escaping (UIImage) -> Void,
                         onError: ((WebServiceError) -> Void)? = nil) {
        getImage(for: model, withSize: 600, onSuccess: onSuccess, onError: onError)
    }
    
}
