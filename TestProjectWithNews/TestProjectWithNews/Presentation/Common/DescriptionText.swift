//
//  DescriptionText.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct DescriptionText: View {
    @State var descriptionText: String
    
    var body: some View {
        Text(descriptionText)
            .font(.subheadline)
            .foregroundColor(.gray)
    }
}

