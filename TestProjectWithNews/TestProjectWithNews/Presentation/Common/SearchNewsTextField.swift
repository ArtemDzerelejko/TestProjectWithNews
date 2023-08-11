//
//  SearchNewsTextField.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

typealias ActionHandler = () -> Void

struct SearchNewsTextField: View {
    
    @State var title: String
    @Binding var text: String
    let action: ActionHandler
    
    var body: some View {
        HStack {
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button(action: {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                                to: nil, from: nil, for: nil)
                action()
            }) {
                Text("Search")
            }
            .foregroundColor(.white)
            .padding(.all, 10)
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}
