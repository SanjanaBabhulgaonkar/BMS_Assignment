//
//  Genres.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//


import Foundation
struct Genres : Decodable {
	let id : Int?
	let name : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
	}

}
