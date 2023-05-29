//
//  Messages.swift
//  Chat_App
//
//  Created by Gi Oo on 29.05.23.
//

import Foundation

struct Message {
    let userID: bubble
    let text: String
}

enum bubble{
    case right
    case left
}
