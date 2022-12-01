//
//  EpisodeModel.swift
//  Interview
//
//  Created by niknil01 on 2022-11-22.
//

import Foundation

class EpisodeModel: Codable {
    
    let id: Int?
    let name: String?
    let description: String?
    let audioUrl: String?
    let lengthInSeconds: Int?
    let imageUrl: String?
    
    init(id: Int?, name: String?, description: String?, audioUrl: String?, lengthInSeconds: Int?, imageUrl: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.audioUrl = audioUrl
        self.lengthInSeconds = lengthInSeconds
        self.imageUrl = imageUrl
    }
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case description
        case audioUrl
        case lengthInSeconds
        case imageUrl
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.audioUrl = try container.decodeIfPresent(String.self, forKey: .audioUrl)
        self.lengthInSeconds = try container.decodeIfPresent(Int.self, forKey: .lengthInSeconds)
        self.imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.name, forKey: .name)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.audioUrl, forKey: .audioUrl)
        try container.encodeIfPresent(self.lengthInSeconds, forKey: .lengthInSeconds)
        try container.encodeIfPresent(self.imageUrl, forKey: .imageUrl)
    }
    
}
