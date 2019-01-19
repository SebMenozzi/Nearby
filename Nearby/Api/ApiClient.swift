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
    case base = "https://akasi.ovh"
}

class APIClient {
    private var baseURL: String
    
    init(baseURL: ServerURL = .base) {
        self.baseURL = baseURL.rawValue
    }
    
    public func request(route: ApiRouter) -> Promise<JSON> {
        
        return Promise<JSON>(in: .background, { resolve, reject, _  in
            let method = route.method
            let url = "\(self.baseURL)\(route.path)"
            
            Alamofire.request(url,
                              method: method,
                              parameters: (method == .get ? nil : route.parameters),
                              encoding: JSONEncoding.default,
                              headers: route.headers
                             ).responseJSON { (response) in                    
                switch response.result {
                    case .success(let json):
                        guard let json = json as? JSON else {
                            return reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        resolve(json)
                    case .failure(let error):
                        print(error)
                        reject(error)
                }
            }
        })
        
    }
}
