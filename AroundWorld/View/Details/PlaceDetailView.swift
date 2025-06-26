//
//  PlaceDetailView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

struct PlaceDetailView: View {
    let place: PlaceDataModel

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    PlaceImageHeader(imageUrl: place.coverPhoto)
                    PlaceStatsView(place: place)
                    PlaceTitleView(title: place.title, location: "Aswan, Egypt.")
                    Divider()
                        .padding(.horizontal)
                    PlaceDescriptionView(description: place.detailedDescription)
                }
                .padding(.top, 8)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}
#Preview {
    let samplePlace = PlaceDataModel(
        id: "1",
        title: "Beautiful Beach",
        coverPhoto: "https://example.com/beach.jpg", description: "A stunning beach with crystal clear water and golden sand.",
        viewsNo: 1000,
        likesNo: 500,
        isLiked: false
    )

    PlaceDetailView(place: samplePlace)
        .previewLayout(.sizeThatFits)
        .padding()
}


private struct PlaceImageHeader: View {
    let imageUrl: String?

    var body: some View {
        ZStack {
            RemoteImageView(urlString: imageUrl, width: UIScreen.main.bounds.width - 8, height: 300)
        }
    }
}

private struct PlaceStatsView: View {
    let place: PlaceDataModel

    var body: some View {
        HStack {
            Label("\(place.viewsNo ?? 0) views", systemImage: "eye")
                .foregroundColor(.secondary)

            Spacer()

            Button(action: {
                
            }) {
                Image(systemName: "square.and.arrow.up")
            }

            Button(action: {
                
            }) {
                HStack {
                    Image(systemName: place.isLiked == true ? "heart.fill" : "heart")
                        .foregroundColor(place.isLiked == true ? .red : .primary)
                    Text("\(place.likesNo ?? 0)")
                }
            }

        }
        .padding(.horizontal)
    }
}

private struct PlaceTitleView: View {
    let title: String?
    let location: String

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title ?? "Unknown Title")
                .font(.title2)
                .bold()
            Text(location)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}

private struct PlaceDescriptionView: View {
    let description: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.title2)
                .bold()
            Text(description ?? "No description available.")
                .font(.body)
        }
        .padding(.horizontal)
    }
}
