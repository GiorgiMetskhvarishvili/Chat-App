//
//  SwitchButtonView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class SwitchButtonView: UIView {
  
  // MARK: - Properties
  
  private var onToggle: ((Bool) -> Void)?
  
  private lazy var button: UIButton = {
    let button = UIButton(type: .custom)
    button.backgroundColor = .clear
    button.setImage(AppImages.switchOffImage, for: .normal)
    button.setImage(AppImages.switchOnImage, for: .selected)
    button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    addSubview(button)
    return button
  }()
  
  // MARK: - Layout
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    NSLayoutConstraint.activate([
      button.widthAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonWidth),
      button.heightAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonHeight)
    ])
  }
  
  // MARK: - Actions
  
  @objc func buttonTapped(_ sender: UIButton) {
    sender.isSelected.toggle()
    updateBackgroundColor()
    onToggle?(sender.isSelected)
  }
  
  // MARK: - Helpers
  
  private func updateBackgroundColor() {
    if button.isSelected {
      backgroundColor = AppColors.darkModeColor
    } else {
      backgroundColor = .white
    }
  }

  func setOnToggle(_ closure: ((Bool) -> Void)?) {
    self.onToggle = closure
  }
}

//MARK: Extension

private extension SwitchButtonView {
  enum AppImages {
    static let switchOffImage = UIImage(named: "switch-off")
    static let switchOnImage =  UIImage(named: "switch-on")
  }
}


