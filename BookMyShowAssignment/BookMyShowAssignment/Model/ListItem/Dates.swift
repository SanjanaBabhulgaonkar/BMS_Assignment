//
//  Dates.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import Foundation

struct Dates : Decodable {
    
	let maximum : String?
	let minimum : String?

	enum CodingKeys: String, CodingKey {

		case maximum = "maximum"
		case minimum = "minimum"
	}
}
