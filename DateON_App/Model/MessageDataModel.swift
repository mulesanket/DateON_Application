//
//  MessageDataModel.swift
//  DateON_App
//
//  Created by Sanket Mule on 06/01/25.
//

import Foundation

struct Message: Identifiable {
    let id: UUID
    let sender: String
    let text: String
    let timestamp: Date
    let isSentByCurrentUser: Bool
}
