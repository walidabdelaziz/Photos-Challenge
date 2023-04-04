//
//  NetworkManager.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case invalidUrl
    case invalidParameters
    case invalidResponse
    case invalidToken
}

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}


    func request<T: Decodable>(_ url: String,
                               method: HTTPMethod = .get,
                               parameters: Parameters? = nil,
                               encoding: ParameterEncoding = JSONEncoding.prettyPrinted,
                               headers: [String: String]? = nil,
                               completionHandler: @escaping (Result<T>) -> Void) {
                
        Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate(statusCode: 200..<300).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(Result.success(decodedObject))
                } catch {
                    completionHandler(Result.failure(.invalidResponse))
                }
            case .failure(_):
                completionHandler(Result.failure(.invalidResponse))
            }
        }
    }

}
