//
//  HomeCache.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation


class HomeCache {
    static let shared = HomeCache()
    
    private let recommendedCache = NSCache<NSString, NSArray>()
    private let recentCache = NSCache<NSString, NSArray>()
    private let searchCache = NSCache<NSString, NSArray>()
    
    func setRecommended(_ experiences: [PlaceDataModel]) {
        recommendedCache.setObject(experiences as NSArray, forKey: "recommended")
    }
    func getRecommended() -> [PlaceDataModel]? {
        recommendedCache.object(forKey: "recommended") as? [PlaceDataModel]
    }
    func setRecent(_ experiences: [PlaceDataModel]) {
        recentCache.setObject(experiences as NSArray, forKey: "recent")
    }
    func getRecent() -> [PlaceDataModel]? {
        recentCache.object(forKey: "recent") as? [PlaceDataModel]
    }
    func setSearch(query: String, _ experiences: [PlaceDataModel]) {
        searchCache.setObject(experiences as NSArray, forKey: query as NSString)
    }
    func getSearch(query: String) -> [PlaceDataModel]? {
        searchCache.object(forKey: query as NSString) as? [PlaceDataModel]
    }
}
