//
//  MessageView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class MessageHistoryView : UIView {

  // MARK: Properties
  private var data = ["როგორ ხარ?", "კარგად",""]
  private let placeHolder = "დაწერე შეტყობინება ..."
  private lazy var messageHistoryView = UIView()
  private lazy var chatBubble = BubbleView()
  let typingMessageView: TypingComponentView

  private lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .clear
    tableView.register(MessageTableViewCell.self, forCellReuseIdentifier: MessageTableViewCell.reuseIdentifier)
    return tableView
  }()

  // MARK: Init

  override init(frame: CGRect) {
    typingMessageView = TypingComponentView(placeHolder: placeHolder, sendButtonImageName: "SendButton")
    super.init(frame: frame)
    setUp()
  }

  required init?(coder: NSCoder) {
    typingMessageView = TypingComponentView(placeHolder: placeHolder, sendButtonImageName: "SendButton")
    super.init(coder: coder)
    setUp()
  }

  private func setUp(){
    setMessageHistoryView()
    setUpMessageViewTable()
    setUpTypingComponentView()
    setUpLayoutConstraints()
  }

  private func setUpTableView(){
    messageHistoryView.addSubview(tableView)
  }

  private func setMessageHistoryView(){
    messageHistoryView.translatesAutoresizingMaskIntoConstraints = false
  }

  private func setUpMessageViewTable(){
    tableView.translatesAutoresizingMaskIntoConstraints = false
    messageHistoryView.addSubview(tableView)
  }

  private func setUpTypingComponentView(){
    typingMessageView.translatesAutoresizingMaskIntoConstraints = false
    messageHistoryView.addSubview(typingMessageView)
  }

  // MARK: Layout constraint
  private func setUpLayoutConstraints(){
    addSubview(messageHistoryView)
    NSLayoutConstraint.activate([
      messageHistoryView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
      messageHistoryView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
      messageHistoryView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
      messageHistoryView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),

      tableView.topAnchor.constraint(equalTo: messageHistoryView.topAnchor, constant: 6),
      tableView.bottomAnchor.constraint(equalTo: typingMessageView.topAnchor, constant: 0),
      tableView.leadingAnchor.constraint(equalTo: messageHistoryView.leadingAnchor, constant: 5),
      tableView.trailingAnchor.constraint(equalTo: messageHistoryView.trailingAnchor, constant: -5),

      typingMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
      typingMessageView.bottomAnchor.constraint(equalTo: messageHistoryView.bottomAnchor, constant: 0),
      typingMessageView.trailingAnchor.constraint(equalTo: messageHistoryView.trailingAnchor, constant: 0),
      typingMessageView.leadingAnchor.constraint(equalTo: messageHistoryView.leadingAnchor, constant: 0),
    ])
  }
}
//დელეგატი წავშალო
extension MessageHistoryView: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.reuseIdentifier, for: indexPath) as! MessageTableViewCell
    cell.backgroundColor = .clear
    cell.messageLabel.text = data[indexPath.row]
    return cell
  }

  //არ მჭირდება
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected item \(indexPath.row + 1)")
  }
}
