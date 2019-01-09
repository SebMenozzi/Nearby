//
//  ApiClient.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 27/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Alamofire
import Hydra

typealias JSON = [String: Any]

public enum ServerURL: String {
    case base = "http://192.168.1.8:3000/api"
}

class APIClient {
    private var baseURL: String
    
    init(baseURL: ServerURL = .base) {
        self.baseURL = baseURL.rawValue
    }
    
    public func request(_ route: ApiRouter, parameters: [String: Any] = [:], headers: HTTPHeaders = [:]) -> Promise<JSON> {
        
        return Promise<JSON>(in: .background, { resolve, reject, _  in
            let method = route.resource.method
            let url = "\(self.baseURL)\(route.resource.route)"
            
            Alamofire.request(url,
                              method: method,
                              parameters: (method == .get ? nil : parameters),
                              encoding: JSONEncoding.default,
                              headers: headers
                             ).responseJSON { (response) in
                switch response.result {
                    case .success(let json):
                        guard let json = json as? JSON else {
                            return reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        resolve(json)
                    case .failure(let error):
                        reject(error)
                }
            }
        })
        
    }
}
