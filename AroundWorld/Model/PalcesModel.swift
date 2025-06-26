//
//  PalcesModel.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation

struct PlacesModel: Codable {
    var meta: MetaModel?
    var data: [PlaceDataModel]?

    enum CodingKeys: String, CodingKey {
        case meta
        case data
    }
}

struct MetaModel: Codable {
    var code: Int?
    var errors: [String]?

    enum CodingKeys: String, CodingKey {
        case code
        case errors
    }
}

// MARK: - Experience
struct PlaceDataModel: Codable, Identifiable , Equatable {
    var id: String?
    var title: String?
    var coverPhoto: String?
    var description: String?
    var viewsNo: Int?
    var likesNo: Int?
    var recommended: Int?
//    var hasVideo: Int?
//    var tags: [TagModel]?
//    var city: CityModel?
//    var tourHtml: String?
//    var famousFigure: String?
//    var period: String?
//    var era: EraModel?
//    var founded: String?
    var detailedDescription: String?
    var address: String?
//    var openingHours: [String: [String]]?
//    var translatedOpeningHours: [String: TranslatedOpeningHourModel]?
//    var startingPrice: Int?
//    var ticketPrices: [TicketPriceModel]?
//    var experienceTips: [String]?
    var isLiked: Bool?
//    var rating: Int?
//    var reviewsNo: Int?
//    var audioUrl: String?
//    var hasAudio: Bool?
//
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case coverPhoto = "cover_photo"
        case description
        case viewsNo = "views_no"
        case likesNo = "likes_no"
        case recommended
//        case hasVideo = "has_video"
//        case tags
//        case city
//        case tourHtml = "tour_html"
//        case famousFigure = "famous_figure"
//        case period
//        case era
//        case founded
        case detailedDescription = "detailed_description"
        case address
//        case openingHours = "opening_hours"
//        case translatedOpeningHours = "translated_opening_hours"
//        case startingPrice = "starting_price"
//        case ticketPrices = "ticket_prices"
//        case experienceTips = "experience_tips"
        case isLiked = "is_liked"
//        case rating
//        case reviewsNo = "reviews_no"
//        case audioUrl = "audio_url"
//        case hasAudio = "has_audio"
    }
}

// MARK: - Tag
struct TagModel: Codable {
    var id: Int?
    var name: String?
    var disable: Bool?
    var topPick: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case disable
        case topPick = "top_pick"
    }
}

struct CityModel: Codable {
    var id: Int?
    var name: String?
    var disable: Bool?
    var topPick: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case disable
        case topPick = "top_pick"
    }
}

struct EraModel: Codable {
    var id: String?
    var value: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct TranslatedOpeningHourModel: Codable {
    var day: String?
    var time: String?

    enum CodingKeys: String, CodingKey {
        case day
        case time
    }
}

struct TicketPriceModel: Codable {
    var type: String?
    var price: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case price
    }
}
