//
//  File.swift
//  Movies
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation
import OMDBApi

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
	
	weak var delegate: MovieDetailViewModelDelegate?
	private let service: OMDBApiService
	private let movieId: String
	private var movieDetail: MovieDetail?
	
	init(with movieId: String, and service: OMDBApiService) {
		self.movieId = movieId
		self.service = service
		load()
	}
	
	private func load() {
		service.fetchMovieDetailByIMDBId(movieId) {[weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let movieDetail):
				self.movieDetail = movieDetail
				if let delegate = self.delegate {
					delegate.showDetail()
				}
			case .failure(let error):
				debugPrint(error)
			}
		}
	}

}

extension MovieDetailViewModel {
	
	func getMovieTitle() -> String {
		guard let title = movieDetail?.title else {
			return "N/A"
		}
		if let year = movieDetail?.year {
			return title + " (" + year + ")"
		}
		return title
	}
	
	func getMovieDirector() -> String {
		guard let director = movieDetail?.director else {
			return "N/A"
		}
		return director
	}
	
	func getMovieWriter() -> String {
		guard let writer = movieDetail?.writer else {
			return "N/A"
		}
		return writer
	}
	
	func getMovieActors() -> String {
		guard let actors = movieDetail?.actors else {
			return "N/A"
		}
		return actors
	}
	
	func getMoviePlot() -> String {
		guard let plot = movieDetail?.plot else {
			return "N/A"
		}
		return plot
	}
	
	func getMovieGenre() -> String {
		guard let genre = movieDetail?.genre else {
			return "N/A"
		}
		return genre
	}
	
	func getMovieRated() -> String {
		guard let rated = movieDetail?.rated else {
			return "N/A"
		}
		return rated
	}
	
	func getMovieReleased() -> String {
		guard let released = movieDetail?.released else {
			return "N/A"
		}
		return released
	}
	
	func getMovieRuntime() -> String {
		guard let runtime = movieDetail?.runtime else {
			return "N/A"
		}
		return runtime
	}
	
	func getMovieLanguage() -> String {
		guard let language = movieDetail?.language else {
			return "N/A"
		}
		return language
	}
	
	func getMovieCountry() -> String {
		guard let country = movieDetail?.country else {
			return "N/A"
		}
		return country
	}
	
	func getMovieAwards() -> String {
		guard let awards = movieDetail?.awards else {
			return "N/A"
		}
		return awards
	}
	
	func getMovieType() -> String {
		guard let type = movieDetail?.type else {
			return "N/A"
		}
		return type
	}
	
	func getMovieDVD() -> String {
		guard let DVD = movieDetail?.DVD else {
			return "N/A"
		}
		return DVD
	}
	
	func getMovieBoxOffice() -> String {
		guard let boxOffice = movieDetail?.boxOffice else {
			return "N/A"
		}
		return boxOffice
	}
	
	func getMovieProduction() -> String {
		guard let production = movieDetail?.production else {
			return "N/A"
		}
		return production
	}
	
	func getMovieWebsite() -> String {
		guard let website = movieDetail?.website else {
			return "N/A"
		}
		return website
	}
	
	func getMovieRatings() -> String {
		guard let ratings = movieDetail?.ratings else {
			return "N/A"
		}
		var ratingsList = [String]()
		ratingsList = ratings.compactMap {
			guard let source = $0.source, let value = $0.value else { return nil }
			return source + " : " + value
		}
		return ratingsList.count > 0 ? ratingsList.joined(separator: "\n") : "N/A"
	}
	
	func getMoviePoster(completion: @escaping (UIImage?) -> Void) {
		if let url = movieDetail?.poster, url != "N/A" {
			service.fetchPoster(url) { (result) in
				switch result {
				case .success(let image):
					completion(image)
				case .failure(let error):
					debugPrint(error)
					completion(UIImage(named: "popcorn"))
				}
			}
		} else {
			completion(UIImage(named: "popcorn"))
		}
	}
	
}
