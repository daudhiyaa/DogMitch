//
//  AgeCalculator.swift
//  MC3
//
//  Created by Daud on 25/07/24.
//

import Foundation

func calculateAge(from birthDate: Date) -> Int? {
    let calendar = Calendar.current
    let currentDate = Date()
    let components = calendar.dateComponents([.year, .month], from: birthDate, to: currentDate)
    
    guard let years = components.year, let months = components.month else {
        return nil
    }
    
    return years * 12 + months
}
