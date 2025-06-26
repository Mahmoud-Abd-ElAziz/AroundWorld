//
//  LikeResponseModel.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import Foundation

struct LikeResponseModel: Codable {
    var meta: MetaModel?
    var data: Int?

    enum CodingKeys: String, CodingKey {
        case meta
        case data
    }
}
