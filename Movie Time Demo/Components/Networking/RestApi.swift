//
//  RestApi.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

struct RestApi {
    let webService = WebService()
}

extension RestApi {
    
    func getMovies(onSuccess: @escaping ([MovieResponseModel]) -> Void,
                   onError: @escaping(WebServiceError) -> Void) {
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
                  onError: @escaping(WebServiceError) -> Void) {
        webService.request(baseUrl: AppConfig.Api.baseLookupUrl,
                           parameters: [
                                "id" : trackId
                            ],
                           onSuccess: onSuccess,
                           onError: onError)
    }
    
}
