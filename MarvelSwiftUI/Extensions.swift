//
//  Extensions.swift
//  MarvelSwiftUI
//
//  Created by egorvedeneev on 26.09.2023.
//

import Foundation
import CryptoKit

extension String {
    var md5: String {
        let computed = Insecure.MD5.hash(data: self.data(using: .utf8)!)
        return computed.map { String(format: "%02hhx", $0) }.joined()
    }
}

extension Date {
    var timeStamp: String {
        return String(Date().timeIntervalSince1970 * 1000)
    }
}
