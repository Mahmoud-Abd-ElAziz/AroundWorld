//
//  SettingView.swift
//  AroundWorld
//
//  Created by Mahmoud Abd ElAziz on 02/08/2025.
//

import SwiftUI

struct SettingView: View {
    
    //MARK: - Properties
    
    
    var body: some View {
        //MARK: - List
        List {
            //MARK: - SECTION : Header
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "laurel.leading")
                        .font(.system(size: 80, weight: .black))
                    
                    VStack(spacing: 5) {
                        Text("Around Egypt")
                            .font(.system(size: 33, weight: .semibold))
                        Text("Editors' Choice")
                            .fontWeight(.medium)
                    }.multilineTextAlignment(.center)
                    
                    Image(systemName: "laurel.trailing")
                        .font(.system(size: 80, weight: .black))
                    Spacer()
                }
          
                
                //: HEADER TEXT
                VStack(spacing: 8) {
                    Text("Around Egypt is a comprehensive guide to the most breathtaking places in Egypt, showcasing the beauty and diversity of its landscapes, culture, and history.")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
            }//: SECTION : Header
            
            Section(header:
                        Text("About the app")
                            .font(.headline)
                            .fontWeight(.semibold),
                    footer: HStack {
                              Spacer()
                              Text("Version 1.0.0")
                              Spacer()
                        }.padding(.vertical, 8)
                         .multilineTextAlignment(.center)
               ){
                
                
                CustomListRow(label: "Developer",
                              content: "Mahmoud Abd ElAziz",
                              icon: "person.fill",
                              iconColor: .blue)
                
                CustomListRow(label: "GitHub",
                              content: nil,
                              icon: "globe",
                              iconColor: .orange,
                              linkLabel: "Visit Profile",
                              linkDestination: "https://github.com/Mahmoud-Abd-ElAziz")
                
                CustomListRow(label: "LinkedIn",
                              content: nil,
                              icon: "globe",
                              iconColor: .orange,
                              linkLabel: "Visit Profile",
                              linkDestination: "https://www.linkedin.com/in/mahmoud-abd-elaziz-707a1316a/")
                
    
                Text("Around Egypt is designed to showcase the beauty and diversity of Egypt's landscapes, culture, and history. It aims to provide users with a comprehensive guide to the most breathtaking places in Egypt, making it easier for them to explore and appreciate the country's rich heritage.")
                    .font(.subheadline)
                    .foregroundColor(.brown)
                    .padding(.horizontal)
                    .padding(.top, 8)
                
            }.multilineTextAlignment(.leading)
        }//:List
    }
    
    

}

#Preview {
    SettingView()
}
