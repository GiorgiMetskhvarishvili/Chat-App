//
//  Message.swift
//  Chat_App
//
//  Created by Gi Oo on 29.05.23.
//

import Foundation

struct Message {
    let userID: Int
    let text: String
    let date: String
}

enum Bubble {
    case left
    case right
}
