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

    private let queue = DispatchQueue(label: "NetworkConnectivityMonitor")
    private let monitor: NWPathMonitor

    private(set) var isConnected: Bool = false

    private init() {
        monitor = NWPathMonitor()
    }

    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .unsatisfied
        }
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
