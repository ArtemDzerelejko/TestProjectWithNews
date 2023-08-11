//
//  SourceName.swift
//  TestProjectWithNews
//
//  Created by artem on 30.07.2023.
//

import SwiftUI

struct SourceName: View {
    
    @State var name: String
    
    var body: some View {
        HStack {
            Text(Strings.name)
            Text(name)
        }
        .foregroundColor(.green)
    }
}
