//
//  HomeScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import SwiftUI

struct HomeScreenView: View {
    @State private var chats: [Chat] = [
        Chat(
            id: UUID(),
            name: "Alice",
            lastMessage: "How are you?",
            timestamp: Date(),
            messages: [
                Message(id: UUID(), sender: "Alice", text: "Hey!", timestamp: Date(), isSentByCurrentUser: false),
                Message(id: UUID(), sender: "You", text: "Hi Alice!", timestamp: Date(), isSentByCurrentUser: true),
                Message(id: UUID(), sender: "Alice", text: "How are you?", timestamp: Date(), isSentByCurrentUser: false)
            ]
        ),
        Chat(
            id: UUID(),
            name: "Bob",
            lastMessage: "See you tomorrow!",
            timestamp: Date(),
            messages: [
                Message(id: UUID(), sender: "Bob", text: "Are you free tomorrow?", timestamp: Date(), isSentByCurrentUser: false),
                Message(id: UUID(), sender: "You", text: "Yes, let’s meet.", timestamp: Date(), isSentByCurrentUser: true),
                Message(id: UUID(), sender: "Bob", text: "See you tomorrow!", timestamp: Date(), isSentByCurrentUser: false)
            ]
        )
    ]
    
    var body: some View {
        NavigationView {
            List(chats) { chat in
                NavigationLink(destination: ChatScreenView(chat: chat)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(chat.name)
                                .font(.headline)
                            Text(chat.lastMessage)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(chat.timestamp, style: .time)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Chats")
        }
    }
}

// MARK: - Preview
struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}
