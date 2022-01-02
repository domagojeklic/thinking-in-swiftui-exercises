//
//  ContentView.swift
//  Picsum
//
//  Created by Domagoj Eklic on 11/21/21.
//

import SwiftUI

private extension URL {

    static var picsumUrl: URL {
        .init(string: "https://picsum.photos/v2/list")!
    }
}

struct ContentView: View {

    typealias Model = [PhotoMetadata]

    @ObservedObject
    private var remote = Remote<Model>(withUrl: .picsumUrl)

    var body: some View {
        NavigationView {
            if let result = remote.result {
                // Data loaded

                if case .success(let model) = result {
                    // Data loaded successfully

                    List {
                        ForEach(model) { photo in
                            NavigationLink(destination: PhotoView(withUrl: photo.downloadUrl)) {
                                Text(photo.author)
                            }
                        }
                    }
                    .navigationTitle("List of authors")
                } else {
                    // Data loading error

                    Text("Error loading data")
                }

            } else {
                // Data still loading

                Text("Loading data...")
            }
        }
        .onAppear {
            remote.load()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
