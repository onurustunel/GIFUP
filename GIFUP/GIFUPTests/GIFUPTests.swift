//
//  GIFUPTests.swift
//  GIFUPTests
//
//  Created by onur on 5.06.2022.
//

import XCTest
@testable import GIFUP

class GIFUPTests: XCTestCase {

    func testRandomJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "random_test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        XCTAssertNotNil(json)
        let randomGIFResponse: RandomGIFResponse? = try! JSONDecoder().decode(RandomGIFResponse.self, from: json)
        XCTAssertNotNil(randomGIFResponse)
        
        guard let randomGIF = randomGIFResponse?.data else { return }
        
        XCTAssertEqual(randomGIF.id, "xT1R9Z3G6MNNOLijAs")
        XCTAssertEqual(randomGIF.shortUrl, "http://gph.is/1NlLgqR")
        XCTAssertEqual(randomGIF.title, "season 9 GIF")
        XCTAssertEqual(randomGIF.rating, "pg-13")
        XCTAssertEqual(randomGIF.images?.originalStill?.url, "https://media2.giphy.com/media/xT1R9Z3G6MNNOLijAs/giphy_s.gif?cid=9c973c43427350360c2cc1c9854b2a0bb4b38c32b3b7e17c&rid=giphy_s.gif&ct=g")
    }
    
    func testSearchedJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "searched_test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        XCTAssertNotNil(json)
        
        let searchedGIFResponse: SearchGIFResponse? = try! JSONDecoder().decode(SearchGIFResponse.self, from: json)
        XCTAssertNotNil(searchedGIFResponse)
        
        guard let searchedGIF = searchedGIFResponse?.data else { return }
        
        XCTAssertEqual(searchedGIF[0].id, "xT1R9Z3G6MNNOLijAs")
        XCTAssertEqual(searchedGIF[0].shortUrl, "http://gph.is/1NlLgqR")
        XCTAssertEqual(searchedGIF[0].title, "season 9 GIF")
        XCTAssertEqual(searchedGIF[0].rating, "pg-13")
        XCTAssertEqual(searchedGIF[0].images?.originalStill?.url, "https://media2.giphy.com/media/xT1R9Z3G6MNNOLijAs/giphy_s.gif?cid=9c973c43427350360c2cc1c9854b2a0bb4b38c32b3b7e17c&rid=giphy_s.gif&ct=g")
        XCTAssertEqual(searchedGIF[1].id, "7WtudzD9XpxXG")
        XCTAssertEqual(searchedGIF[1].shortUrl, "http://gph.is/217tYRn")
        XCTAssertEqual(searchedGIF[1].title, "model kids GIF")
        XCTAssertEqual(searchedGIF[1].rating, "g")
        XCTAssertEqual(searchedGIF[1].images?.originalStill?.url, "https://media2.giphy.com/media/7WtudzD9XpxXG/giphy_s.gif?cid=9c973c43mhss9w7bxpeyzya2mwh77tohlmpc37z5nauww1w5&rid=giphy_s.gif&ct=g")
    }
    
    func testHomeViewModel_random_case() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "random_test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        XCTAssertNotNil(json)
        let randomGIFResponse: RandomGIFResponse? = try! JSONDecoder().decode(RandomGIFResponse.self, from: json)
        XCTAssertNotNil(randomGIFResponse)
        
        guard let randomGIFData = randomGIFResponse?.data else { return }
        let viewModel: HomeViewModelProtocol = HomeViewModel()
       
        viewModel.randomGIFData = randomGIFData
        
        let randomGIFCount = viewModel.randomNumberOfItemsInSection()
        XCTAssertEqual(randomGIFCount, 1)
        
        let cellData = viewModel.randomGIFcellForRow()
        XCTAssertEqual(cellData.id, "xT1R9Z3G6MNNOLijAs")
        XCTAssertEqual(cellData.shortUrl, "http://gph.is/1NlLgqR")
        XCTAssertEqual(cellData.title, "season 9 GIF")
        XCTAssertEqual(cellData.rating, "pg-13")
        
        XCTAssertNotNil(viewModel.randomGIFData)
        /// Clear randomGIFData
        viewModel.clearRandomGIF()
        sleep(5)
        XCTAssertNil(viewModel.randomGIFData)
    }
    
    func testHomeViewModel_search_case() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "searched_test", withExtension: "json") else {
            XCTFail("Missing file: test.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        XCTAssertNotNil(json)
        let searchGIFResponse: SearchGIFResponse? = try! JSONDecoder().decode(SearchGIFResponse.self, from: json)
        XCTAssertNotNil(searchGIFResponse)
        
        guard let searchGIFData = searchGIFResponse?.data else { return }
        let viewModel: HomeViewModelProtocol = HomeViewModel()
        /// Current clicked searched data...
        viewModel.searchedGIFData = searchGIFData
        
        let searchedGIFArrayCount = viewModel.searchedNumberOfItemsInSection()
        XCTAssertEqual(searchedGIFArrayCount, 2)
        
        let cellData = viewModel.searchedGIFcellForRow(index: 0)
        XCTAssertEqual(cellData?.id, "xT1R9Z3G6MNNOLijAs")
        XCTAssertEqual(cellData?.shortUrl, "http://gph.is/1NlLgqR")
        XCTAssertEqual(cellData?.title, "season 9 GIF")
        XCTAssertEqual(cellData?.rating, "pg-13")
        /// GifImageCell Data
        let ImageCellSearchedGIFArray = viewModel.searchedGIFImageCellForRow(index: 0)
        XCTAssertEqual(ImageCellSearchedGIFArray?.imageLink, "https://media2.giphy.com/media/xT1R9Z3G6MNNOLijAs/giphy_s.gif?cid=9c973c43427350360c2cc1c9854b2a0bb4b38c32b3b7e17c&rid=giphy_s.gif&ct=g")
        
        XCTAssertNotNil(viewModel.searchedGIFData)
        /// Clear searchedGIFData
        viewModel.clearSearchedGIF()
        sleep(5)
        XCTAssertNil(viewModel.searchedGIFData)
    }
    
    func testHomeViewModel_sectionHeader() throws {
        let viewModel: HomeViewModelProtocol = HomeViewModel()
        let sectionHeaderTitle = viewModel.sectionHeader()
        XCTAssertEqual(sectionHeaderTitle, Constants.firstLunchHeader)
    }
    
    func testGIFDetailViewModel() throws {
        let viewModel: GifDetailViewModelProtocol =  GifDetailViewModel(title: "test", id: "123", rating: "pg-13", shortUrl: "http://gph.is/1NlLgqR")
        let rating = viewModel.ratingDecide()
        XCTAssertEqual(rating, "+13")
    }

}
