//
//  MessageView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class MessageHistoryView: UIView {

  // MARK: Properties
  private var data = ["როგორ ხარ?", "კარგად","1234567"]
  private let placeHolder = "დაწერე შეტყობინება ..."
  private lazy var typingMessageView: TypingComponentView = {
    let typingMessageView = TypingComponentView()
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
    typingMessageView.setUpView(with: color)
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
      tableView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.messageHistoryViewTopBottomLeadingTrailing),

      typingMessageView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
      typingMessageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.typingMessageViewTopBottomTrailingLeading),
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
    cell.configure(with: data[indexPath.row])
    cell.selectionStyle = .none
    return cell
  }
}

extension MessageHistoryView {
  enum Constants {
    static let messageHistoryViewTopBottomLeadingTrailing: CGFloat = 0
    static let tableViewTopPadding: CGFloat = 6
    static let tableViewBottomPadding: CGFloat = 0
    static let tableViewLeadingPadding: CGFloat = 5
    static let tableViewTrailingPadding: CGFloat = -5
    static let typingMessageViewTopBottomTrailingLeading: CGFloat = 0
  }
}
