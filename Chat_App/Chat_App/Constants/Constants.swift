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

//MARK: topMessageHistoryView Extension
enum TopMessageHistoryViewConstants {
  static let topAnchor: CGFloat = 15
  static let bottomAnchor: CGFloat = -30
}

// MARK: DividerViewConstants Extension
enum DividerViewConstants {
  static let dividerHeightConstans: CGFloat = 6
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

  static let containerBorderColor = CGColor(red: 0.62,
                                            green: 0.38,
                                            blue: 1.00,
                                            alpha: 1.00)

  static let bubbleColor = CGColor(red: 241,
                                   green: 241,
                                   blue: 241, alpha: 1)
}

