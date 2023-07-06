//
//  MessageHistoryViewModel.swift
//  Chat_App
//
//  Created by Gi Oo on 07.06.23.
//

import Foundation
import UIKit

protocol ChatViewModelDelegate: AnyObject {
    func messagesLoaded()
}

class ConversationViewModel {
    weak var delegate: ChatViewModelDelegate?
    private let coreDataManager = CoreDataManager()
    private var sentMessages = [MessageEntity]()

    //MARK: - Load messages from coreData
    func loadMessages() {
        if let messages = coreDataManager.loadObjects(with: coreDataManager.request) {
            sentMessages = messages
            delegate?.messagesLoaded()
        } else {
            print("Error fetching objects")
        }
    }

    //MARK: - Remove data from coreData
    func removeMessages() {
        coreDataManager.removeData(entityType: MessageEntity.self)
        delegate?.messagesLoaded()
    }
    
    //MARK: - Create new Message
    func sendMessages(with text: String, userID: Int32, date: String, isSent: Bool) {
        let newMessage = MessageEntity(context: coreDataManager.context)
        newMessage.userID = userID
        newMessage.text = text
        newMessage.date = date
        newMessage.isSent = isSent

        sentMessages.append(newMessage)
        coreDataManager.saveItems()
        delegate?.messagesLoaded()
        print("Message sent")
    }

    func numberOfMessages(userId: Int) -> Int {
        return sentMessages.filter({sentMessage in filterMessage(message: sentMessage, userId: userId)}).count
    }

    //MARK: - Get a message at a specific index
    func message(userId: Int, index: Int) -> MessageEntity {
        return sentMessages.filter({sentMessage in filterMessage(message: sentMessage, userId: userId)})[index]
    }

    private func filterMessage(message: MessageEntity, userId: Int) -> Bool {
        return message.userID == userId || message.isSent
    }
}
