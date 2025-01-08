//
//  ChatDataModel.swift
//  DateON_App
//
//  Created by Sanket Mule on 06/01/25.
//

import Foundation

struct Chat: Identifiable {
    let id: UUID
    let name: String
    let lastMessage: String
    let timestamp: Date
    let messages: [Message]
}
