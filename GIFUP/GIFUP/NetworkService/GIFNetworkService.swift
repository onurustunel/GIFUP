//
//  GIFNetworkService.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import UIKit
import Alamofire

/// GIFNetworkServiceProtocol
protocol GIFNetworkServiceProtocol {
    func fetchRandomGIF(completion: @escaping (GIFModel?) -> Void)
    func fetchSearchedGIF(searchText: String, completion: @escaping ([GIFModel]?) -> Void)
}

/// URL creates for request
enum GIFNetworkServiceEndPoint: String {
    case BASE_URL = "https://api.giphy.com/v1/gifs/"
    case RANDOM = "random?"
    case SEARCH = "search?"
    
    static func randomGIFUrl() -> String {
        return "\(BASE_URL.rawValue)\(RANDOM.rawValue)"
    }
    static func searchGIFUrl() -> String {
        return "\(BASE_URL.rawValue)\(SEARCH.rawValue)"
    }
}

struct GIFNetworkService: GIFNetworkServiceProtocol  {
    
    /// This function sends network request and gives GIFModel type data.
    /// - Parameter completion: GIFModel base model type
    func fetchRandomGIF(completion: @escaping (GIFModel?) -> Void) {
        let url = "\(GIFNetworkServiceEndPoint.randomGIFUrl())"
        let parameters: [String: String] = ["api_key": "\(apiKey)"]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: RandomGIFResponse.self) { response in
                guard let data = response.value else {
                    completion(nil)
                    return
                }
                completion(data.data)
            }
    }
    
    /// This function sends network request  to search a GIF and gives [GIFModel] type data.
    /// - Parameter completion: [GIFModel] base model type array
    func fetchSearchedGIF(searchText: String, completion: @escaping ([GIFModel]?) -> Void) {
        let url = "\(GIFNetworkServiceEndPoint.searchGIFUrl())"
        let parameters: [String: String] = ["api_key": "\(apiKey)",
                                            "q": "\(searchText)"]
        AF.request(url, parameters: parameters)
            .validate()
            .responseDecodable(of: SearchGIFResponse.self) { response in
                guard let data = response.value else {
                    completion(nil)
                    return
                }
                completion(data.data)
            }
    }
    
}

extension GIFNetworkService {
    /// our secret api key
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "GIPHY", ofType: "plist") else {
                fatalError("Couldn't find file GIPHY.plist.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in GIPHY.plist.")
            }
            return value
        }
    }
}

