//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//

import UIKit

class ViewController: UIViewController {

  // MARK: Properties
  private let topMessageHistoryView = MessageHistoryView()
  private let dividerView = DividerView()
  private let bottomChatHistoryView = MessageHistoryView()
  private let switchButtonView = SwitchButtonView()

  override func viewDidLoad() {
    super.viewDidLoad()

    [topMessageHistoryView,
     dividerView,
     switchButtonView,
     bottomChatHistoryView,].forEach(view.addSubview)
     setUpLayoutConstraints()
  }

  // MARK: Layout constraint
  private func setUpLayoutConstraints() {
    [topMessageHistoryView, dividerView, bottomChatHistoryView,switchButtonView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }

    NSLayoutConstraint.activate([
      topMessageHistoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      topMessageHistoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      topMessageHistoryView.bottomAnchor.constraint(equalTo: dividerView.topAnchor, constant: -30),
      topMessageHistoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

      dividerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      dividerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

      bottomChatHistoryView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
      bottomChatHistoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomChatHistoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomChatHistoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

      switchButtonView.topAnchor.constraint(equalTo: topMessageHistoryView.topAnchor, constant: 0),
      switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -12),
      switchButtonView.widthAnchor.constraint(equalToConstant: 54),
      switchButtonView.heightAnchor.constraint(equalToConstant: 27),
    ])
  }
}


