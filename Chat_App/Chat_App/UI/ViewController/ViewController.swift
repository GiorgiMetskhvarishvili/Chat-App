//
//  ViewController.swift
//  Chat_App
//
//  Created by Gi Oo on 24.04.23.
//
import UIKit

class ViewController: UIViewController {

  // MARK: Properties
  private lazy var topMessageHistoryView = MessageHistoryView()
  private lazy var dividerView = UIView()
  private lazy var bottomChatHistoryView = MessageHistoryView()
  private lazy var switchButtonView = SwitchButtonView()

  override func viewDidLoad() {
    super.viewDidLoad()

    addSubviews()
    setUpLayoutConstraints()
    dividerView.backgroundColor = AppColors.dividerViewColor

    switchButtonView.setOnToggle { [weak self] isOn in
      if isOn {
        self?.view.backgroundColor = AppColors.darkModeColor
      } else {
        self?.view.backgroundColor = .white
      }
    }
  }

  //MARK: Add Subviews
  private func addSubviews() {
    [topMessageHistoryView, dividerView, switchButtonView, bottomChatHistoryView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
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

      dividerView.topAnchor.constraint(equalTo: topMessageHistoryView.bottomAnchor),
      dividerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      dividerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      dividerView.heightAnchor.constraint(equalToConstant: DividerViewConstants.dividerHeightConstans),
      dividerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      
      bottomChatHistoryView.topAnchor.constraint(equalTo: dividerView.bottomAnchor),
      bottomChatHistoryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      bottomChatHistoryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      bottomChatHistoryView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

      switchButtonView.topAnchor.constraint(equalTo: topMessageHistoryView.topAnchor, constant: SwitchButtonViewConstants.switcherTopPadding),
      switchButtonView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: SwitchButtonViewConstants.trailingAnchor),
      switchButtonView.widthAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonWidth),
      switchButtonView.heightAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonHeight),
    ])
  }
}


