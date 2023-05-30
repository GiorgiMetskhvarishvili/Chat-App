//
//  MessageView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class MessageHistoryView: UIView {

//    func addMessage(_ message: Message) {
//          dummyData.append(message)
//          tableView.reloadData()
//          scrollToLastMessage()
//      }
//
//      private func scrollToLastMessage() {
//          let lastRowIndex = dummyData.count - 1
//          if lastRowIndex >= 0 {
//              let lastIndexPath = IndexPath(row: lastRowIndex, section: 0)
//              tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//          }
//      }

    var dummyData: [Message] = [
        Message(userID: 1, text: "როგორ ხარ?"),
        Message(userID: 2, text: "კარგად შენ?"),
        Message(userID: 1, text: "კარგად, კარგად, კარგად, კარგად, კარგად, კარგად, კარგად, კარგად, კარგად,"),
        Message(userID: 2, text: "dsfs, dsfs, dsfs, dsfs, dsfs, dsfs, dsfs, dsfs, dsfs, dsfs, ")
    ]

    // MARK: Properties
    private lazy var typingMessageView: TypingComponentView = {
        let typingMessageView = TypingComponentView(messageHistoryView: self)
        typingMessageView.translatesAutoresizingMaskIntoConstraints = false
        return typingMessageView
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpTypingComponentView(with color: UIColor) {
        typingMessageView.setUpTextView(with: color)
    }

    private func setUp(){
        setUpTableView()
        setUpTypingComponentView()
    }

    // MARK: Layout constraint
    private func setUpTableView(){
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),
        ])
    }

    private func setUpTypingComponentView(){
        addSubview(typingMessageView)
        NSLayoutConstraint.activate([
            typingMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
            typingMessageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
            typingMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
            typingMessageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
        ])
    }
}
//MARK: UITableViewDataSource
extension MessageHistoryView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
        let message = dummyData[indexPath.row]
        if  message.userID == 1 {
            cell.setUpLeftBubbleLayoutConstraints()
        } else {
            cell.setUpRightBubbleLayoutConstraints()
            cell.setUpSecondBubbleColor()
        }
        cell.configure(with: message)
        return cell
    }
}
//MARK: Constants
extension MessageHistoryView {

    enum Constants {
        static let messageHistoryViewTopBottomLeadingTrailing: CGFloat = 0
        static let tableViewTopPadding: CGFloat = 6
        static let tableViewBottomPadding: CGFloat = 0
        static let tableViewLeadingPadding: CGFloat = 5
        static let tableViewTrailingPadding: CGFloat = -5
        static let typingMessageViewTopBottomTrailingLeading: CGFloat = 0
        static let placeHolderText = "დაწერე შეტყობინება ..."
    }
}
private extension MessageHistoryView.Constants {
    static let messageLeadingPadding: CGFloat = 16
    static let messageTrailingPadding: CGFloat = -16
    static let messageTopPadding: CGFloat = 8
}



