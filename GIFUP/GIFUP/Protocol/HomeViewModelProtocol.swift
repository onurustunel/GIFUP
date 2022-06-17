//
//  HomeViewModelProtocol.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation

/// HomeViewModelProtocol
protocol HomeViewModelProtocol: AnyObject {
    var randomGIFData: GIFModel? { get set }
    var searchedGIFData: [GIFModel]? { get set }
    var searchGIFText: String? { get set }
    var gifNetworkService: GIFNetworkServiceProtocol { get }
    var bindNewDataArrived: Bindable<()?> { get }
    func fetchRandomGIF()
    func searchedNumberOfItemsInSection() -> Int
    func randomNumberOfItemsInSection() -> Int
    func searchedGIFcellForRow(index: Int) -> GifDetailViewModel?
    func searchedGIFImageCellForRow(index: Int) -> GifImageCellViewModel?
    func randomGIFcellForRow() -> GifDetailViewModel
    func clearRandomGIF()
    func clearSearchedGIF()
    func sectionHeader() -> String
}
