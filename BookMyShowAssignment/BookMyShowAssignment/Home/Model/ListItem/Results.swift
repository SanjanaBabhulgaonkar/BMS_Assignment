//
//  Results.swift
//  BookMyShowAssignment
//
//  Created by Sanjana Babhulgaonkar on 25/04/21.
//

import Foundation

struct Results : Decodable {
    
	let poster_path : String?
	let adult : Bool?
	let overview : String?
	let release_date : String?
	let genre_ids : [Int]?
	let id : Int?
	let original_title : String?
	let original_language : String?
	let title : String?
	let backdrop_path : String?
	let popularity : Double?
	let vote_count : Int?
	let video : Bool?
	let vote_average : Double?

	enum CodingKeys: String, CodingKey {

		case poster_path = "poster_path"
		case adult = "adult"
		case overview = "overview"
		case release_date = "release_date"
		case genre_ids = "genre_ids"
		case id = "id"
		case original_title = "original_title"
		case original_language = "original_language"
		case title = "title"
		case backdrop_path = "backdrop_path"
		case popularity = "popularity"
		case vote_count = "vote_count"
		case video = "video"
		case vote_average = "vote_average"
	}
}
