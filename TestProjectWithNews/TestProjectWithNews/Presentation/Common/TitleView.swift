//
//  TitleView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct TitleView: View {
    @State var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 25, weight: .bold))
            .foregroundColor(.black)
    }
}
