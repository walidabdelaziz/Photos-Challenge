//
//  Photos.swift
//  Photos Task
//
//  Created by Walid Ahmed on 04/04/2023.
//

import Foundation

struct Photos: Codable {
    var id: String?
    var author: String?
    var width, height: Int?
    var url, downloadURL: String?

    enum CodingKeys: String, CodingKey {
        case id, author, width, height, url
        case downloadURL = "download_url"
    }
}
