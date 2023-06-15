//
//  Date.swift
//  Chat_App
//
//  Created by Gi Oo on 13.06.23.
//

import Foundation
import UIKit

extension DateFormatter {
    static func formatCustomDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,HH:mm"
        return dateFormatter.string(from: date).uppercased()
    }
}
