//
//  CustomListRow.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 02/08/2025.
//

import SwiftUI

struct CustomListRow: View {
    
    @State var label: String
    @State var content: String?
    @State var icon: String
    @State var iconColor: Color
    
    @State var linkLabel: String?
    @State var linkDestination: String?
    
    
    var body: some View {
        
        LabeledContent {
            if content != nil {
                Text(content!)
                    .font(.headline)
                    .foregroundColor(.gray)
            }else if linkLabel != nil && linkDestination != nil {
                Link(linkLabel ?? "", destination: URL(string: linkDestination ?? "")!)
                    .foregroundColor(.blue)
            } else {
                EmptyView()
            }
        } label: {
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor)
                        .frame(width: 30, height: 30)
                    
                    Image(systemName: icon)
                        .foregroundColor(.white)
                }
                Text(label)
                    .fontWeight(.semibold)
            }
        }.multilineTextAlignment(.leading)
    }
    
    
}

#Preview {
    List {
        CustomListRow(label: "Custom Row",
                      content: "content",
                      icon: "star.fill",
                      iconColor: .yellow,
                      linkLabel: nil,
                      linkDestination: nil)
    }
}
