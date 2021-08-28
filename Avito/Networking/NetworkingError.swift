//
//  NetworkingError.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import Foundation

//MARK: FOR MANAGER
enum ErrorResponse: Error {
    case badServerResponse
    case cantGetData
    case badURL
}

extension ErrorResponse: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badServerResponse:
            return NSLocalizedString("Проблемы с сервером. Пожалуйста, проверьте есть ли у вас доступ к интернету", comment: "Ошибка")
        case .cantGetData:
            return NSLocalizedString("Проблемы с получением данных", comment: "Ошибка")
        case .badURL:
            return NSLocalizedString("Проблемы с URL", comment: "Ошибка")
        }
    }
}
