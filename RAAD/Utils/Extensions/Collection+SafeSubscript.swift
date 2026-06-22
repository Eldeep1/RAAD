//
//  Collection+SafeSubscript.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

extension Collection {

    /// Returns the element at the given index, or `nil` if the index is out of bounds.
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
