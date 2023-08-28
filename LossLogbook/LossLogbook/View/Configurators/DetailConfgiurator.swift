//
//  DetailConfgiuration.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import Foundation


protocol TableRepresentable {
    var propertyList: [(key: String, value: String?)] { get }
}

extension TableRepresentable {
    var propertyList: [(key: String, value: String?)] {
        var properties: [(key: String, value: String?)] = []
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let label = child.label {
                let valueString: String?
                if let value = child.value as? CustomStringConvertible {
                    valueString = value.description
                } else {
                    valueString = "No data"
                }
                properties.append((label, valueString))
            }
        }
        
        return properties
    }
}

