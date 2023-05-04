//
//  SwitchButtonView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class SwitchButtonView: UIView {

  // MARK: - Properties

  private lazy var button: UIButton = {
    let button = UIButton(type: .custom)
    button.setImage(UIImage(named: "switch-off"), for: .normal)
    button.setImage(UIImage(named: "switch-on"), for: .selected)
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    addSubview(button)
    return button
  }()

  // MARK: - Actions

  func updateBackgroundColor() {
    if button.isSelected {
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let rootViewController = windowScene.windows.first?.rootViewController {
        rootViewController.view.backgroundColor = UIColor(red: 22/255, green: 0, blue: 57/255, alpha: 1)
      }
    } else {
      UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
      if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
         let rootViewController = windowScene.windows.first?.rootViewController {
        rootViewController.view.backgroundColor = .white
      }
    }
  }

  @objc func buttonTapped(_ sender: UIButton) {
    sender.isSelected = !sender.isSelected
    updateBackgroundColor()
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()

    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalToConstant: 54),
      button.heightAnchor.constraint(equalToConstant: 27)
    ])
  }
}

