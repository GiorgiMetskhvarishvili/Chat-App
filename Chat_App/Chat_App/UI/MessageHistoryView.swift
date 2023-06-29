//
//  MessageView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

protocol SendMessageDelegate: AnyObject {
    func sendButton(with text: String, view: MessageHistoryView)
}

class MessageHistoryView: UIView {

    weak var sendMessageDelegate: SendMessageDelegate?

    // MARK: Properties
    lazy var typingMessageView: TypingComponentView = {
        let view = TypingComponentView(messageHistoryView: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.buttonDelegate = self
        return view
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

    private func setUp() {
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
    func example(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
}


extension MessageHistoryView: buttonActionProcoloc {
    func buttonTapped(with text: String) {
        sendMessageDelegate?.sendButton(with: text, view: self)
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



