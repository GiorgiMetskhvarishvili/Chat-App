//
//  NetworkManeger.swift
//  Chat_App
//
//  Created by Gi Oo on 28.06.23.
//

import Foundation
import Network

final class NetworkManager {
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()

    private(set) var isConnected: Bool = true {
        didSet {
            NotificationCenter.default.post(name: .networkConnectivityDidChange, object: nil)
        }
    }

    private init() {
        startMonitoring()
    }

    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            print(self?.isConnected ?? false)
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}

extension Notification.Name {
    static let networkConnectivityDidChange = Notification.Name("networkConnectivityDidChange")
}
