//
//  ImageLoader.swift
//  Picsum
//
//  Created by Domagoj Eklic on 11/21/21.
//

import Foundation

class ImageLoader: ObservableObject {

    let url: URL

    @Published
    var data: Data?

    init(withUrl url: URL) {
        self.url = url
    }

    func loadImage() {
        let urlRequest = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            DispatchQueue.main.async {
                self.data = data
            }
        }

        task.resume()
    }
}
