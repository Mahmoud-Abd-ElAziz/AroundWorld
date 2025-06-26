//
//  SearchBarView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 26/06/2025.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    var onSearch: () -> Void
    var onClear: () -> Void
    
    var body: some View {
        HStack {
            TextField("Try \"Luxor\"", text: $text, onCommit: onSearch)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
            if !text.isEmpty {
                Button(action: onClear) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
    }
}
#Preview {
    @Previewable @State var searchText = ""
    return SearchBarView(text: $searchText, onSearch: {}, onClear: {})
}
