//
//  HomeViewModel.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var recommended: [PlaceDataModel] = []
    @Published var recent: [PlaceDataModel] = []
    @Published var searchResults: [PlaceDataModel] = []
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var loading = false
    @Published var error: String?

    private let apiService: APIServiceProtocol
    private var cache = HomeCache.shared

    init(apiService: APIServiceProtocol = APIService.shared, cache: HomeCache = .shared) {
        self.apiService = apiService
        self.cache = cache
        
    }
    
    //MARK: - Load data
    func loadCachedData() {
        if let cachedRecommended = cache.getRecommended() {
            recommended = cachedRecommended
        }
        if let cachedRecent = cache.getRecent() {
            recent = cachedRecent
        }
    }
    
    func loadExperiences() async {
        loading = true
        error = nil
        do {
            let rec = try await apiService.fetchRecommendedExperiences(isRecommended: true)
            self.updateRecommended(rec)
        } catch {
            self.error = "Failed to load: \(error.localizedDescription)"
        }
        loading = false
    }

    func loadRecent() async {
        await MainActor.run { loading = true }
        error = nil
        do {
            let recentEx = try await apiService.searchExperiences(query: searchText)
            await MainActor.run { self.updateRecent(recentEx) }
        } catch {
            await MainActor.run { self.error = "Failed to load: \(error.localizedDescription)" }
        }
        await MainActor.run { loading = false }
    }
    
    func search() async {
        isSearching = true
        error = nil
        if let cached = cache.getSearch(query: searchText) {
            searchResults = cached
            return
        }
        do {
            let results = try await apiService.searchExperiences(query: searchText)
            searchResults = results
            cache.setSearch(query: searchText, results)
        } catch {
            self.error = "Search failed: \(error.localizedDescription)"
        }
    }
    
    func likeExperience(_ experience: PlaceDataModel) async {
        do {
            let newLikes = try await apiService.likeExperience(id: experience.id ?? "")
            recommended  = updateLikes(in: recommended, for: experience, with: newLikes)
            recent       = updateLikes(in: recent, for: experience, with: newLikes)
            searchResults = updateLikes(in: searchResults, for: experience, with: newLikes)
           
            cache.setRecommended(recommended)
            cache.setRecent(recent)
            if isSearching {
                cache.setSearch(query: searchText, searchResults)
            }
        } catch {
            self.error = "Failed to like: \(error.localizedDescription)"
        }
    }

    private func updateLikes(in array: [PlaceDataModel], for experience: PlaceDataModel, with newLikes: Int) -> [PlaceDataModel] {
        array.map { item in
            if item.id == experience.id {
                var updated = item
                updated.isLiked = true
                updated.likesNo = newLikes
                return updated
            }
            return item
        }
    }
    
    
    
   //MARK: -  Hndle updates
    func updateRecommended(_ data: [PlaceDataModel]) {
        recommended = data
        cache.setRecommended(data)
    }
    
    func updateRecent(_ data: [PlaceDataModel]) {
        recent = data
        cache.setRecent(data)
    }
    func clearSearch() {
        isSearching = false
        searchText = ""
        searchResults = []
    }
    

    
}
