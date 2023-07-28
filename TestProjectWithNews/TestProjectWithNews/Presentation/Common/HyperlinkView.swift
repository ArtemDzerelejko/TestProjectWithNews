//
//  URLLink.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct HyperlinkView: View {
    @State var url: String? // Зміна типу на String?

    var body: some View {
        if let validURL = URL(string: url ?? "") { // Конвертуємо рядок в URL
            Link(destination: validURL) {
                Text(validURL.absoluteString)
                    .multilineTextAlignment(.leading)
                    .font(.system(size: 15))
                    .foregroundColor(.blue)
                    .underline()
            }
        } else {
            Text("Invalid URL")
                .foregroundColor(.red)
        }
    }
}
