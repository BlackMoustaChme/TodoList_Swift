//
//  SwiftUIView.swift
//  TodoList
//
//  Created by Michael Chernousov on 02.02.2024.
//

import SwiftUI

struct SwiftUIView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var todo: Todo
    
    let onSave: (Todo) -> Void
    
    var body: some View {
        VStack {
            TextField("Title", text: $todo.title)
            TextField("Text", text: $todo.text)
            Toggle("Check", isOn: $todo.check)
            Spacer()
            Button("Save") {
                onSave(todo)
                dismiss()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    SwiftUIView(todo: Todo(id: 1, title: "Title", creationDate: "01.01.2001", text: "Avas", check: false), onSave: { _ in })
}
