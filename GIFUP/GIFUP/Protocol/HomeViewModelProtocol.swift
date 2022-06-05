//
//  HomeViewModelProtocol.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation

/// HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
    func fetchRandomGIF()
    var randomGIFData: GIFModel? { get set }
    var searchedGIFData: [GIFModel]? { get set }
    var searchGIFText: String? { get set }
    var gifNetworkService: GIFNetworkServiceProtocol { get }
    var delegate: HomeOutput? { get }
    func setDelegate(outPut: HomeOutput)
    func searchedNumberOfItemsInSection() -> Int
    func searchedGIFcellForRow(index: Int) -> GifDetailViewModel?
    func searchedGIFImageCellForRow(index: Int) -> GifImageCellViewModel?
    func randomNumberOfItemsInSection() -> Int
    func randomGIFcellForRow() -> GifDetailViewModel
    func clearRandomGIF()
    func clearSearchedGIF()
    func sectionHeader() -> String
}
