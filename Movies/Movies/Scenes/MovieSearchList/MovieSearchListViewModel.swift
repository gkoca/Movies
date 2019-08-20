//
//  MovieSearchListViewModel.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit
import Foundation
import OMDBApi

final class MovieSearchListViewModel: MovieSearchListViewModelProtocol {

	

	
	weak var delegate: MovieSearchListViewModelDelegate?
	private let service: OMDBApiService
	private var items = [Search]()
	
	init(with service: OMDBApiService) {
		self.service = service
	}
	
	func search(by title: String, year: String = "", type: String = "") {
		 notify(.setLoading(true))
		debugPrint(title,year,type, separator: "|", terminator: "#")
		
				service.searchMovies { (result) in
					self.notify(.setLoading(false))
					switch result {
						
					case .success(let response):
						self.items = response.search ?? [Search]()
						self.notify(.showMovieList)
					case .failure(let error):
						debugPrint(error)
					}
					
				}
		
	}
	
	func selectMovie(at index: Int) {
		
	}
	
	private func notify(_ output: MovieSearchListViewModelOutput) {
		delegate?.handleViewModelOutput(output)
	}
	
	func getNumberOfItems() -> Int {
		return items.count
	}
	
	public func getMoviePoster(at index: Int) -> UIImage? {
		return UIImage(named: "popcorn")
	}
	
	public func getMovieTitle(at index: Int) -> String {
		return items[index].title ?? "No title"
	}
	
	public func getMovieYear(at index: Int) -> String {
		return items[index].year ?? "----"
	}
	
	public func getMovieType(at index: Int) -> String {
		return (items[index].type ?? "unknown").capitalized
	}
}
