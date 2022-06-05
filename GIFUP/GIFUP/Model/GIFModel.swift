//
//  GIFModel.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation
// MARK:- Response Models
struct RandomGIFResponse: Codable {
    let data: GIFModel?
}

struct SearchGIFResponse: Codable {
    let data: [GIFModel]?
}

// MARK:- Main Model
struct GIFModel: Codable {
    let id: String?
    let shortUrl: String?
    let title: String?
    let rating: String?
    let images: GIFPreview?

    enum CodingKeys: String, CodingKey {
        case id
        case shortUrl = "bitly_url"
        case title
        case rating
        case images
    }
}

// MARK:- Additional Models
struct GIFPreview: Codable {
    let originalStill: GIFPreviewLink?

    enum CodingKeys: String, CodingKey {
        case originalStill = "original_still"
    }
}

struct GIFPreviewLink: Codable {
    let url: String?

    enum CodingKeys: String, CodingKey {
        case url
    }
}
