//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Michael Chernousov on 02.02.2024.
//

import SwiftUI

struct SwiftUIView: View {
    @State var text = "Hi!"
    var body: some View {
        VStack {
            Text(text)
            TextField("", text: $text)
        }
    }
}

#Preview {
    SwiftUIView()
}
