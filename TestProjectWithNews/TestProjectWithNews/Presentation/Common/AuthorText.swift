//
//  AuthorTitle.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct AuthorText: View {
    @State var author: String
    var body: some View {
        HStack {
            Text(Strings.author)
            Text(author)
        }
        .font(.system(size: 15, weight: .medium))
            
    }
}
