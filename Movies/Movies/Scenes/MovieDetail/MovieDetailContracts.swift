//
//  MovieDetailContracts.swift
//  Movies
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

protocol MovieDetailViewModelDelegate: class {
	func showDetail()
}

protocol MovieDetailViewModelProtocol {
	var delegate: MovieDetailViewModelDelegate? { get set }
	
	func getMovieTitle() -> String
	func getMovieDirector() -> String
	func getMovieWriter() -> String
	func getMovieActors() -> String
	func getMoviePlot() -> String
	func getMovieGenre() -> String
	func getMovieRated() -> String
	func getMovieReleased() -> String
	func getMovieRuntime() -> String
	func getMovieLanguage() -> String
	func getMovieCountry() -> String
	func getMovieAwards() -> String
	func getMovieType() -> String
	func getMovieDVD() -> String
	func getMovieBoxOffice() -> String
	func getMovieProduction() -> String
	func getMovieWebsite() -> String
	func getMovieRatings() -> String
	func getMoviePoster(completion: @escaping (UIImage?) -> Void)
}
