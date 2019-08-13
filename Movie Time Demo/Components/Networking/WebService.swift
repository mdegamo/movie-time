//
//  WebService.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Alamofire

struct WebService {
    private let genericError: WebServiceError = (
        title: R.string.localizable.error(),
        detail: R.string.localizable.unexpectedErrorMessage()
    )
    
    private static let sessionManager: Alamofire.SessionManager = {
        let config = URLSessionConfiguration.default
        
        // This is set to `nil` just to get rid of the error message in console.
        // The error message is actually not a bug with Alamofire. See: https://github.com/Alamofire/Alamofire/issues/2467
        config.urlCredentialStorage = nil

        return Alamofire.SessionManager(configuration: config)
    }()
}

extension WebService {
    
    func request(baseUrl: String,
                  parameters: Parameters? = [:],
                  onSuccess: @escaping ([MovieResponseModel]) -> Void,
                  onError: @escaping(WebServiceError) -> Void) {
        let dataRequest = WebService.sessionManager
            .request(baseUrl,
                     method: .get,
                     parameters: parameters,
                     encoding: URLEncoding.default)
        
        Log.debug("cURL Output", dataRequest)
        dataRequest.responseData { response in
            self.handleResponseData(response,
                                    onSuccess: onSuccess,
                                    onError: onError)
        }
    }
    
    func handleResponseData(_ response: DataResponse<Data>,
                             onSuccess: @escaping ([MovieResponseModel]) -> Void,
                             onError: @escaping(WebServiceError) -> Void) {
        
        guard let statusCode = response.response?.statusCode else {
            Log.error("Can't get status code")
            onError(genericError)
            return
        }
        
        guard let validData = response.data, validData.count > 0 else {
            Log.error("Input data nil or zero length")
            onError(genericError)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            
            switch statusCode {
            case 200...299:
                Log.debug("Success Valid Data", validData)
                let model = try decoder.decode(MovieListResponseModel.self, from: validData)
                Log.debug("Success", model)
                if model.resultCount == 0 {
                    onError(genericError)
                } else {
                    onSuccess(model.results)
                }
            default:
                Log.debug("Server error")
                onError((
                    title: R.string.localizable.serverError(),
                    detail: R.string.localizable.serverErrorMessage()
                ))
            }
        } catch {
            Log.severe("JSON decode error", error)
            onError(genericError)
        }
    }
    
}
