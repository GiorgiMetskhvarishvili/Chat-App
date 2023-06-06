//
//  SwitchButtonView.swift
//  Chat_App
//
//  Created by Gi Oo on 26.04.23.
//

import UIKit

class SwitchButtonView: UIView {
    
    // MARK: Components
    var onToggle: ((Bool) -> Void)?
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.setImage(SwitchButtonImages.switchOffImage, for: .normal)
        button.setImage(SwitchButtonImages.switchOnImage, for: .selected)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        return button
    }()
    
    // MARK: LifeCycle
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonWidth),
            button.heightAnchor.constraint(equalToConstant: SwitchButtonViewConstants.switchButtonHeight)
        ])
    }
    
    // MARK: Actions
    @objc func buttonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        updateBackgroundColor()
        onToggle?(sender.isSelected)
    }
    
    // MARK: Methods
    private func updateBackgroundColor() {
        backgroundColor = button.isSelected ? AppColors.darkModeColor : .white
    }
}




