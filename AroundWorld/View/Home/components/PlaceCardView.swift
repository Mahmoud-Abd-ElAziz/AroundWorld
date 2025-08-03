//
//  PlaceCardView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

struct PlaceCardView: View {
    let place: PlaceDataModel
    let likeAction: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                RemoteImageView(
                    urlString: place.coverPhoto,
                    width: UIScreen.main.bounds.width - 32,
                    height: 180
                )
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

                Button(action: likeAction) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(place.isLiked == true ? .orange : .gray)
                        .padding(8)
                        .background(Color.white.opacity(0.7))
                        .clipShape(Circle())
                }
                .padding(10)
            }

            Text(place.title ?? "")
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.9)
                .padding(.horizontal, 12)
            
            HStack {
                Image(systemName: "eye")
                Text("\(place.viewsNo ?? 0)")
                Spacer()
                Image(systemName: "heart.fill")
                Text("\(place.likesNo ?? 0)")
            }
            .font(.subheadline)
            .foregroundColor(.gray)
            .padding(12)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.10), radius: 6, x: 0, y: 3)
        .frame(width: UIScreen.main.bounds.width - 32)
        .padding(.horizontal, 8)
    }
}


#Preview {
    let place = PlaceDataModel(
        id: "1",
        title: "template Experience",
        description: "This is a place description for the experience.",
        viewsNo: 100,
        likesNo: 50,
        isLiked: false
    )
    
    PlaceCardView(place: place, likeAction: {})
        .previewLayout(.sizeThatFits)
        .padding()
}
