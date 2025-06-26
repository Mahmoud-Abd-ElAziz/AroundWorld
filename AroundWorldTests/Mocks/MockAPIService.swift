//
//  MockAPIService.swift
//  AroundWorldTests
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation
@testable import AroundWorld

final class MockAPIService: APIServiceProtocol {
    var likeResult: Int = 0
    var likeShouldFail = false

    func fetchRecommendedExperiences(isRecommended: Bool) async throws -> [PlaceDataModel] {
        return []
    }

    func searchExperiences(query: String) async throws -> [PlaceDataModel] {
        return []
    }

    func likeExperience(id: String) async throws -> Int {
        if likeShouldFail { throw NSError(domain: "Test", code: 1, userInfo: nil) }
        return likeResult
    }
    
    
}
