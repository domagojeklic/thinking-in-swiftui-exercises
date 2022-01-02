//
//  PhotoMetadata.swift
//  Picsum
//
//  Created by Domagoj Eklic on 11/21/21.
//

import Foundation

// JSON example
//    {
//    "id": "0",
//    "author": "Alejandro Escamilla",
//    "width": 5616,
//    "height": 3744,
//    "url": "https://unsplash.com/photos/yC-Yzbqy7PY",
//    "download_url": "https://picsum.photos/id/0/5616/3744"
//    }

struct PhotoMetadata: Decodable {
    let identifier: String
    let author: String
    let width: UInt
    let height: UInt
    let url: URL
    let downloadUrl: URL

    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case author
        case width
        case height
        case url
        case downloadUrl = "download_url"
    }
}

extension PhotoMetadata: Identifiable {
    var id: String {
        identifier
    }
}
