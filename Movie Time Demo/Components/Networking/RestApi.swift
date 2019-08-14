//
//  RestApi.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

struct RestApi {
    
    static let shared = RestApi()
    
    private let webService: WebService
    
    private init() {
        webService = WebService()
    }
    
}

extension RestApi {
    
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
    
    func getMovie(byId trackId: TrackId,
                  onSuccess: @escaping ([MovieResponseModel]) -> Void,
                  onError: @escaping (WebServiceError) -> Void) {
        webService.request(baseUrl: AppConfig.Api.baseLookupUrl,
                           parameters: [
                                "id" : trackId
                            ],
                           onSuccess: onSuccess,
                           onError: onError)
    }
    
    func getThumbnail(for model: MovieResponseModel,
                      onSuccess: @escaping (UIImage) -> Void,
                      onError: ((WebServiceError) -> Void)? = nil) {
        if let url = model.artworkUrl {
            if let index = url.lastIndex(of: "/") {
                let betterThumbUrl = "\(url[..<index])/300x300.jpg"
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
    
}
