//
//  HomeViewModel.swift
//  GIFUP
//
//  Created by onur on 5.06.2022.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    
    var searchedGIFData: [GIFModel]? // After Searched GIF, assign here
    var randomGIFData: GIFModel? // After fetched random GIF, assign here
    var hasData: Bool = false // If false, shows Constants.firstLunchHeader in collectionview header
    
    var searchGIFText: String? {
        didSet {
            fetchSearchedGIF(text: searchGIFText)
        }
    }
    /// Notify data is arrived and reload collectionview
    var bindNewDataArrived = Bindable<()?>()
    
    /// Network Service
    var gifNetworkService: GIFNetworkServiceProtocol
    
    init(gifNetworkService: GIFNetworkServiceProtocol =  GIFNetworkService()) {
        self.gifNetworkService = gifNetworkService
    }
        
    /// Shows searchedGIFData Count to use on numberOfItemsInSection
    /// - Returns: searchedGIFData.count
    func searchedNumberOfItemsInSection() -> Int {
        return searchedGIFData?.count ?? 0
    }
    
    /// Shows randomGIFData Count for collectionview
    /// - Returns: randomGIFData.count
    func randomNumberOfItemsInSection() -> Int {
        return randomGIFData == nil ? 0 : 1
    }
    
    /// Build CollectionViewCell with searchedGIF data
    /// - Parameter index: IndexPath.row
    /// - Returns: GifDetailViewModel to use on cellForItemAt function
    func searchedGIFcellForRow(index: Int) -> GifDetailViewModel? {
        guard let currentGIF = searchedGIFData?[index] else { return nil }
        return GifDetailViewModel(title: currentGIF.title ?? "",
                                  id: currentGIF.id ?? "",
                                  rating: currentGIF.rating ?? "",
                                  shortUrl: currentGIF.shortUrl ?? "")
    }
    
    /// Build CollectionViewCell with randomGIFcell data
    /// - Returns: GifDetailViewModel to use on cellForItemAt function
    func randomGIFcellForRow() -> GifDetailViewModel {
        return GifDetailViewModel(title: randomGIFData?.title ?? "",
                                  id: randomGIFData?.id ?? "",
                                  rating: randomGIFData?.rating ?? "",
                                  shortUrl: randomGIFData?.shortUrl ?? "")
    }
    
    /// Build CollectionViewCell for image preview
    /// - Parameter index: IndexPath.row
    /// - Returns: GifImageCellViewModel to preview image previews
    func searchedGIFImageCellForRow(index: Int) -> GifImageCellViewModel? {
        guard let currentGIF = searchedGIFData?[index] else { return nil}
        return GifImageCellViewModel(imageLink: currentGIF.images?.originalStill?.url ?? "")
    }
    
    /// Determines Section Header
    /// - Returns: String
    func sectionHeader() -> String {
        if !hasData { return Constants.firstLunchHeader }
        return randomGIFData == nil ? Constants.searchCellHeader : Constants.randomCellHeader
    }
    
    /// This function runs api request and gives us a result.
    func fetchRandomGIF() {
        gifNetworkService.fetchRandomGIF { [weak self] (result) in
            self?.randomGIFData = result
            self?.bindNewDataArrived.value = ()
            self?.hasData = true
        }
    }
    
    /// This function runs api request when searched more than 1 word
    /// - Parameter text: searchGIFText
    func fetchSearchedGIF(text: String?) {
        guard let text = text else { return }
        gifNetworkService.fetchSearchedGIF(searchText: text) { [weak self] (searchedGIFArray) in
            self?.searchedGIFData = searchedGIFArray
            self?.bindNewDataArrived.value = ()
        }
    }
    
    /// Clear randomGIFData Array
    func clearRandomGIF() {
        randomGIFData = nil
        bindNewDataArrived.value = ()
    }
    
    /// Clear randomGIFData Array. DispatchQoS.QoSClass = background
    func clearSearchedGIF() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            self?.searchedGIFData = nil
        }
    }
}

