//
//  PhotoView.swift
//  Picsum
//
//  Created by Domagoj Eklic on 11/21/21.
//

import SwiftUI

struct PhotoView: View {

    @ObservedObject
    var imageLoader: ImageLoader

    init(withUrl url: URL) {
        imageLoader = ImageLoader(withUrl: url)
    }

    var body: some View {
        Group {
            if let data = imageLoader.data {
                if let image = UIImage(data: data) {
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Spacer()
                    }
                } else {
                    Text("Problem loading image")
                }
            } else {
                ProgressView()
            }
        }
        .onAppear {
            imageLoader.loadImage()
        }
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(withUrl: URL(string: "https://picsum.photos/id/0/5616/3744")!)
    }
}
