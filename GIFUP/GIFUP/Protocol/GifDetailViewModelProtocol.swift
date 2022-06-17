//
//  GifDetailViewModelProtocol.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation

/// GifDetailViewModelProtocol
protocol GifDetailViewModelProtocol {
    func titleDecide() -> String
    func linkDecide() -> String
    func ratingDecide() -> String
    func hideRatingLabel() -> Bool
}

