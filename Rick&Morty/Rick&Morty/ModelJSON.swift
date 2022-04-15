//
//  ModelJSON.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import Foundation

struct RequestResult: Codable {
    let info: Info
    let results: [Result]
}

struct Info: Codable {
    let count, pages: Int
}

struct Result: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct Location: Codable {
    let name: String
    let url: String
}
