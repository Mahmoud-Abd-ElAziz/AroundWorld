//
//  AroundWorldTests.swift
//  AroundWorldTests
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import XCTest
@testable import AroundWorld

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var mockAPIService: MockAPIService!
    var mockCache: MockHomeCache!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockCache = MockHomeCache()
        viewModel = HomeViewModel(apiService: mockAPIService, cache: mockCache)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        mockCache = nil
        super.tearDown()
    }

    
    
    
    func testLoadCachedData_setsRecommendedAndRecent() {
      
        let recommended = [PlaceDataModel(id: "1", title: "Rec", coverPhoto: nil)]
        let recent = [PlaceDataModel(id: "2", title: "Recent", coverPhoto: nil)]
        mockCache.recommendedStub = recommended
        mockCache.recentStub = recent
        
        viewModel.loadCachedData()

        XCTAssertEqual(viewModel.recommended, recommended)
        XCTAssertEqual(viewModel.recent, recent)
    }

    func testUpdateRecommended_setsAndCaches() {
        let data = [PlaceDataModel(id: "123", title: "Title", coverPhoto: nil)]
        viewModel.updateRecommended(data)
        XCTAssertEqual(viewModel.recommended, data)
        XCTAssertEqual(mockCache.setRecommendedCalledWith, data)
    }
    func testClearSearch_resetsSearchState() {
        viewModel.isSearching = true
        viewModel.searchText = "Test"
        viewModel.searchResults = [PlaceDataModel(id: "1", title: "Rec", coverPhoto: nil)]

        viewModel.clearSearch()

        
        
        XCTAssertFalse(viewModel.isSearching)
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertTrue(viewModel.searchResults.isEmpty)
        
        
    }

    func testLikeExperience_updatesLikesOnAllArrays() async {
        let exp = PlaceDataModel(id: "1", title: "Rec", coverPhoto: nil, likesNo: 0, isLiked: false)
        viewModel.recommended = [exp]
        viewModel.recent = [exp]
        viewModel.searchResults = [exp]
        mockAPIService.likeResult = 10
        
        await viewModel.likeExperience(exp)

       
        XCTAssertEqual(viewModel.recommended.first?.likesNo, 10)
        XCTAssertTrue(viewModel.recommended.first?.isLiked ?? false)
    }

    func testLikeExperience_handlesError() async {
        let exp = PlaceDataModel(id: "1", title: "Rec", coverPhoto: nil)
        mockAPIService.likeShouldFail = true

        await viewModel.likeExperience(exp)
        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.error!.contains("Failed to like"))
    }
    
    
    
    
}

