//
//  SourceId.swift
//  TestProjectWithNews
//
//  Created by artem on 30.07.2023.
//

import SwiftUI

struct SourceId: View {
    
    @State var id: String
    
    var body: some View {
        HStack {
            Text(Strings.id)
            Text(id)
        }
        .foregroundColor(.red)
    }
}


