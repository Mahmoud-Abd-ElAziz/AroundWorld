//
//  HeaderView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

//MARK: - HeaderView
struct HeaderView: View {
    @Binding var title: String
    @Binding var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle.bold())
            Text(subtitle)
                .font(.body)
        }
        .padding(.horizontal)
    }
}
#Preview {
    @Previewable @State var title = "Welcome!"
    @Previewable @State var subtitle = "Now you can explore any experience in 360 degrees and get all the details about it all in one place."

    HeaderView(title:  $title , subtitle: $subtitle)
        .previewLayout(.sizeThatFits)
        .padding()
}
