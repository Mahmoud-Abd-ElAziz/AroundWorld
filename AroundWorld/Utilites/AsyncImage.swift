//
//  AsyncImage.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

struct RemoteImageView: View {
    let urlString: String?
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        if let urlString, let url = URL(string: urlString) {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: width, height: height)
                        .background(Color.gray.opacity(0.1))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: width, height: height)
                        .clipped()
                        .ignoresSafeArea(edges: .top)
                case .failure:
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: width, height: height)
                        .overlay(Text("Image failed").foregroundColor(.white))
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

