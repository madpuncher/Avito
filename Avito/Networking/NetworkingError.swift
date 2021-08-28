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
            return NSLocalizedString("Возникли проблемы с сервером. Пожалуйста, проверьте есть ли у вас доступ к интернету, а после нажмите на кнопку перезагрузки таблицы. Он расположен в правом верхнем углу", comment: "Ошибка")
        case .cantGetData:
            return NSLocalizedString("Возникли проблемы с получением данных", comment: "Ошибка")
        case .badURL:
            return NSLocalizedString("Возникли проблемы с URL", comment: "Ошибка")
        }
    }
}
