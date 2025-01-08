//
//  ChatScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 06/01/25.
//

import SwiftUI

struct ChatScreenView: View {
    let chat: Chat
    
    var body: some View {
        VStack {
            Text("Chat with \(chat.name)")
                .font(.largeTitle)
                .padding()
            Spacer()
        }
        .navigationTitle(chat.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ChatScreenView(chat: Chat(
        id: UUID(),
        name: "Alice",
        lastMessage: "How are you?",
        timestamp: Date(),
        messages: [
            Message(
                id: UUID(),
                sender: "Alice",
                text: "Hey!",
                timestamp: Date(),
                isSentByCurrentUser: false
            )
        ]
    ))
}
