//
//  Car.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import Foundation

struct Car: Decodable {
    let id: Int
    let brand: String
    let model: String
    let yearOfProduction: Int
    let photo: String
    let price: Int
}
