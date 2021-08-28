//
//  Employee.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import Foundation

struct EmployeeInfo: Decodable {
    public let company: Company
}

struct Company: Decodable {
    public let name: String
    public let employees: [Employee]
}

struct Employee: Decodable {
    public let name: String
    public let phoneNumber: String
    public let skills: [String]
}
