//
//  ChatBubbleView.swift
//  Chat_App
//
//  Created by Gi Oo on 01.05.23.
//

//import UIKit
//
//class BubbleView: UIView {
//
//  override func draw(_ rect: CGRect) {
//    let bezierPath = UIBezierPath()
//    //Draw main body
//    bezierPath.move(to: CGPoint(x: rect.minX, y: rect.minY))
//    bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//    bezierPath.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
//    bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
//    bezierPath.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
//
//    //Draw the tail
//    bezierPath.move(to: CGPoint(x: rect.maxX - 25.0, y: rect.maxY - 10.0))
//    bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY))
//    bezierPath.addLine(to: CGPoint(x: rect.maxX - 10.0, y: rect.maxY - 10.0))
//    UIColor.lightGray.setFill()
//    bezierPath.fill()
//    bezierPath.close()
//  }
//}
////MARK: - Constants
//private extension BubbleView {
//  enum Constants {
//    static let radius = 25.0
//  }
//}

