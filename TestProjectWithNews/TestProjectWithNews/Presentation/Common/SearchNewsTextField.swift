//
//  SearchNewsTextField.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct SearchNewsTextField: View {
    @State var title: String
    @Binding var text: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: action) {
                Text("Пошук")
            }
        }
        .padding()
        
        
    }
}
