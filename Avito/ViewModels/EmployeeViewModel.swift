//
//  EmployeeViewModel.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import Foundation

class EmployeeViewModel: Comparable {
    let companyName: String
    let employeeName: String
    let phoneNumber: String
    let skills: [String]
    var image: Int
    var scoreFirst: Int
    var scoreSecond: Int
    
    init(companyName: String, employeeName: String, phoneNumber: String, skills: [String], image: Int, scoreFirst: Int, scoreSecond: Int) {
        self.companyName = companyName
        self.employeeName = employeeName
        self.phoneNumber = phoneNumber
        self.skills = skills
        self.image = image
        self.scoreFirst = scoreFirst
        self.scoreSecond = scoreSecond
    }
    
    static func <(lhs: EmployeeViewModel, rhs: EmployeeViewModel) -> Bool {
        return lhs.employeeName < rhs.employeeName
    }
    
    static func == (lhs: EmployeeViewModel, rhs: EmployeeViewModel) -> Bool {
        lhs.employeeName == rhs.employeeName
    }
}
