//
//  Content.swift
//  Lentach
//
//  Created by Andrey on 00/00/00.
//  Copyright © 2019 Andrey. All rights reserved.
//

import Foundation

final class Content: Decodable {

    enum Types: String, Decodable {
        case video = "eagleplatform"
        case paragraph = "p"
        case another

        init(from decoder: Decoder) throws {

            self = try Types(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .another
        }
    }

    enum DataTypes: Decodable {

        case video(NewsVideo)
        case text(String)
        case another

        init(from decoder: Decoder) throws {

            let container = try decoder.singleValueContainer()

            if let text = try? container.decode(String.self) {
                self = .text(text)
                return
            } else if let video = try? container.decode(NewsVideo.self) {
                self = .video(video)
                return
            } else {
                self = .another
                return
            }
        }
    }

    // MARK: - Public Properties
    // MARK: -- Model Properties
    let type: Types?
    let data: DataTypes?
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case type
        case data = "content"
        case imageURL = "preview_image_url"
    }

    // MARK: - Lifecycle
    // MARK: -- Initializations
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decodeIfPresent(Types.self, forKey: .type)
        self.data = try container.decodeIfPresent(DataTypes.self, forKey: .data)
        self.imageURL = try container.decodeIfPresent(URL.self, forKey: .imageURL)
    }

}
