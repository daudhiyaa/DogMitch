//
//  Personality.swift
//  MC3
//
//  Created by Daud on 16/07/24.
//

import Foundation

struct Personality: Identifiable, Hashable {
    let id = UUID()
    let value: String
    
    init(value: String) {
        self.value = value
    }
}
