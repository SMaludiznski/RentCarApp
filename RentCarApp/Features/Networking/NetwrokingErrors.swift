//
//  NetwrokingErrors.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import Foundation

enum NetworkingErrors: LocalizedError {
    case wrongURL
    case decodingError
    case downloadingError
    case wrongServerResponse
    
    var errorDescription: String? {
        switch self {
        case .wrongURL:
            return NSLocalizedString("The URL isn't correct!", comment: "")
        case .decodingError:
            return NSLocalizedString("There is a problem with data decoding!", comment: "")
        case .downloadingError:
            return NSLocalizedString("There is a problem with data downloading!", comment: "")
        case .wrongServerResponse:
            return NSLocalizedString("The server response isn't correct!", comment: "")
        }
    }
}
