//
//  Remote.swift
//  Picsum
//
//  Created by Domagoj Eklic on 11/21/21.
//

import Foundation
import Combine

enum LoadingError: Error {
    case networking(Error)
    case missingData
    case decoding
}

final class Remote<Model: Decodable>: ObservableObject {

    private let url: URL

    @Published
    var result: Result<Model, LoadingError>?

    init(withUrl url: URL) {
        self.url = url
    }

    func load() {

        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            DispatchQueue.main.async {
                // Publish changes from the main queue

                guard error == nil else {
                    self.result = .failure(.networking(error!))

                    return
                }

                guard let data = data else {
                    self.result = .failure(.missingData)

                    return
                }

                guard let model = try? self.createModelFromRemoteData(data) else {
                    self.result = .failure(.decoding)

                    return
                }


                self.result = .success(model)
            }
        }

        task.resume()
    }

    private func createModelFromRemoteData(_ data: Data) throws -> Model {

        let decoder = JSONDecoder()

        return try decoder.decode(Model.self, from: data)
    }
}
