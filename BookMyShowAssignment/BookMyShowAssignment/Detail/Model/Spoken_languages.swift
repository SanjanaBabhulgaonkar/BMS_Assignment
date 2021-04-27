//
//  Spoken_languages.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import Foundation
struct Spoken_languages : Decodable {
	let iso_639_1 : String?
	let name : String?

	enum CodingKeys: String, CodingKey {

		case iso_639_1 = "iso_639_1"
		case name = "name"
	}

}
