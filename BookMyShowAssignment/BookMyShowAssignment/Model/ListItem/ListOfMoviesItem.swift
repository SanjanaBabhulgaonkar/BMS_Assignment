
//
//  ListOfMoviesItem.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import Foundation

struct ListOfMoviesItem : Decodable {
	let page : Int?
	let results : [Results]?
	let dates : Dates?
	let total_pages : Int?
	let total_results : Int?

	enum CodingKeys: String, CodingKey {

		case page = "page"
		case results = "results"
		case dates = "dates"
		case total_pages = "total_pages"
		case total_results = "total_results"
	}
}
