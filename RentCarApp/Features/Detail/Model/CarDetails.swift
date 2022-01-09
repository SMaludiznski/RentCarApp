//
//  CarDetail.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 08/01/2022.
//

import Foundation

struct CarDetails: Decodable {
    let hP: Int
    let rate: Double
    let torque: Int
    let location: String
    let fuelConsumption: Double
    let driveType: String
    let secondsToHundred: Double
    let fuel: String
    let gearbox: String
    let comfort: [String]
}
