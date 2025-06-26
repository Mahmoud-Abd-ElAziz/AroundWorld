//
//  MockHomeCache.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation
@testable import AroundWorld

final class MockHomeCache: HomeCache {
    var recommendedStub: [PlaceDataModel]?
    var recentStub: [PlaceDataModel]?
    var searchStub: [PlaceDataModel]?
    var setRecommendedCalledWith: [PlaceDataModel]?
    var setRecentCalledWith: [PlaceDataModel]?

    override func getRecommended() -> [PlaceDataModel]? { recommendedStub }
    override func getRecent() -> [PlaceDataModel]? { recentStub }
    override func getSearch(query: String) -> [PlaceDataModel]? { searchStub }

    override func setRecommended(_ data: [PlaceDataModel]) { setRecommendedCalledWith = data }
    override func setRecent(_ data: [PlaceDataModel]) { setRecentCalledWith = data }
}
