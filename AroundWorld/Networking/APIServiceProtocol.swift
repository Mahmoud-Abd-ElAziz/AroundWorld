//
//  APIServiceProtocol.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//


import Foundation

protocol APIServiceProtocol {
    func fetchRecommendedExperiences(isRecommended: Bool) async throws -> [PlaceDataModel]
    func searchExperiences(query: String) async throws -> [PlaceDataModel]
    func likeExperience(id: String) async throws -> Int
}

final class APIService: APIServiceProtocol {
    static  let shared = APIService()
    private let host = "https://aroundegypt.34ml.com"
    
    private func request<T: Decodable>(_ endpoint: String, method: String = "GET") async throws -> T {
        guard let url = URL(string: host + endpoint) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        request.httpMethod = method
        if method == "POST" {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        print("➡️ REQUEST: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
           let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
           let prettyString = String(data: prettyData, encoding: .utf8) {
            print("⬅️ RESPONSE: \(prettyString)")
        } else {
            print("⬅️ RESPONSE DATA: \(String(data: data, encoding: .utf8) ?? "Unable to parse data")")
        }

        guard let httpResp = response as? HTTPURLResponse, (200...299).contains(httpResp.statusCode) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetchRecommendedExperiences(isRecommended: Bool = true) async throws -> [PlaceDataModel] {
        let resp: PlacesModel = try await request("/api/v2/experiences?filter[recommended]=\(isRecommended)")
        return resp.data ?? []
    }
    
    func searchExperiences(query: String) async throws -> [PlaceDataModel] {
        let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let resp: PlacesModel = try await request("/api/v2/experiences?filter[title]=\(encoded)")
        return resp.data ?? []
    }
    
    func likeExperience(id: String) async throws -> Int {
        let resp: LikeResponseModel = try await request("/api/v2/experiences/\(id)/like", method: "POST")
        guard let likesCount = resp.data else {
            throw URLError(.badServerResponse)
        }
        return likesCount
    }
    
    
}
