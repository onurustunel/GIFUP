//
//  GifDetailViewModel.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation

/// GifDetailViewModel
struct GifDetailViewModel {
    let title: String
    let id: String
    let rating: String
    let shortUrl: String
    
    /// creates GIF url with id
    var gifPreviewUrl: URL? {
        return URL(string: "https://media.giphy.com/media/\(id)/giphy.gif")
    }
}

extension GifDetailViewModel: GifDetailViewModelProtocol {
    func titleDecide() -> String {
        title == "" ? "No description" : "\(title)"
    }
    
    func linkDecide() -> String {
        shortUrl  == "" ? "Link is not available" : "\(shortUrl)"
    }
    
    /// Use rating property and returns age restrictions
    /// - Returns: age restrictions
    func ratingDecide() -> String {
        switch rating {
        case "g":
            return ""
        case "pg":
            return ""
        case "pg-13":
            return "+13"
        case "r":
            return "+17"
        default:
            return ""
        }
    }
}

