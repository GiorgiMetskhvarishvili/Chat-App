//
//  Constants.swift
//  Chat_App
//
//  Created by Gi Oo on 05.05.23.
//

import UIKit

// MARK: SwitchButtonViewConstants Extension
enum SwitchButtonViewConstants {
  static let switchButtonWidth: CGFloat = 54
  static let switchButtonHeight: CGFloat = 27
  static let switcherTopPadding: CGFloat = 0
  static let trailingAnchor: CGFloat = -12
}

// MARK: DividerViewConstants Extension
enum DividerViewConstants {
  static let dividerHeightConstans: CGFloat = 6
}

// MARK: ContainerViewConstants Extension
enum ContainerViewConstants {
    static let containerCornerRadius: CGFloat = 28
    static let containerBorderWidth: CGFloat = 1
    static let containerbottomPadding: CGFloat = 30
    static let containerLeadingPadding: CGFloat = 16
    static let containerTrailingPadding: CGFloat = -16

    static let sendButtonWidthAndHeight: CGFloat = 32
    static let sendButtonTrailingPadding: CGFloat = -12
    static let sendButtonBottomPadding: CGFloat = -12

    static let textViewtopLeadingPadding: CGFloat = 10
    static let textViewbottomPadding: CGFloat = -10
    static let textViewtrailingPadding: CGFloat = -5
    static let textViewFontSize: CGFloat = 16
}

// MARK: MessageTableViewCellcConstants Extension
enum MessageTableViewCellcConstants {
  
}


enum AppColors {
    static let dividerViewColor = UIColor(red: 0.97,
                                          green: 0.81,
                                          blue: 0.50,
                                          alpha: 1.0)

    static let darkModeColor = UIColor(red: 22/255,
                                       green: 0,
                                       blue: 57/255,
                                       alpha: 1)

    static let containerBorderColor = UIColor(red: 0.62,
                                             green: 0.38,
                                             blue: 1.00,
                                             alpha: 1.00)
}


enum AppImages {
    static let switchOffImage = UIImage(named: "switch-off")
    static let switchOnImage =  UIImage(named: "dark_Mode")
    static let sendButtonImmage = UIImage(named: "SendButton")
}
