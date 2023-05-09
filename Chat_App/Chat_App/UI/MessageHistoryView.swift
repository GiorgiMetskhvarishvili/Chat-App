//
//  MessageView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class MessageHistoryView: UIView {

  // MARK: Properties
  private var data = ["როგორ ხარ?", "კარგად",""]
  private let placeHolder = "დაწერე შეტყობინება ..."
  private lazy var typingMessageView: TypingComponentView = {
    let typingMessageView = TypingComponentView(placeHolder: placeHolder, sendButtonImageName: SendButtonImage.sendButtonImageName)
    typingMessageView.translatesAutoresizingMaskIntoConstraints = false
    return typingMessageView
  }()

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.dataSource = self
    tableView.backgroundColor = .clear
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

  private func setUp(){
    setUpTableView()
    setUpTypingComponentView()
    setUpLayoutConstraints()
  }

  private func setUpTableView(){
    addSubview(tableView)
  }

  private func setUpTypingComponentView(){
    addSubview(typingMessageView)
  }

  // MARK: Layout constraint
  private func setUpLayoutConstraints(){
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: topAnchor, constant: MessageHistoryViewConstants.messageHistoryViewTopBottomLeadingTrailing),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MessageHistoryViewConstants.messageHistoryViewTopBottomLeadingTrailing),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MessageHistoryViewConstants.messageHistoryViewTopBottomLeadingTrailing),

      typingMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: MessageHistoryViewConstants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: MessageHistoryViewConstants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: MessageHistoryViewConstants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MessageHistoryViewConstants.typingMessageViewTopBottomTrailingLeading),
    ])
  }
}

//MARK: Extension

extension MessageHistoryView: UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
    tableView.separatorStyle = .none
    cell.backgroundColor = .clear
    cell.messageLabel.text = data[indexPath.row]
    return cell
  }
}

extension MessageHistoryView {
  enum SendButtonImage {
    static let sendButtonImageName = "SendButton"
  }
}
