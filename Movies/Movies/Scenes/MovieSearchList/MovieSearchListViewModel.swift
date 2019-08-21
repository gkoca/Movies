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
	private var totalResults = 0
	private var currentPage = 0
	private var isLoadingMore = false
	
	private var searchParameterTitle: String = ""
	private var searchParameterType: String = ""
	private var searchParameterYear: String = ""
	
	init(with service: OMDBApiService) {
		self.service = service
	}
	
	func search(by title: String, year: String = "", type: String = "") {
		notify(.setLoading(true))
		searchParameterTitle = title
		searchParameterType = type
		searchParameterYear = year
		currentPage = 1
		isLoadingMore = false
		service.searchMovies(by: title, type: type, year: year, page: 1, completion: processResult(_:))
	}
	
	func loadMore() {
		if totalResults > items.count {
			currentPage += 1
			isLoadingMore = true
			service.searchMovies(by: searchParameterTitle, type: searchParameterType, year: searchParameterYear, page: currentPage, completion: processResult(_:))
		}
	}
	
	private func processResult(_ result: Result<MovieSearch>) {
		debugPrint(result)
		debugPrint("==================================================")
		self.notify(.setLoading(false))
		switch result {
		case .success(let response):
			totalResults = response.totalResults ?? 0
			if isLoadingMore {
				let responseSearch = response.search ?? [Search]()
				self.items.append(contentsOf: responseSearch)
			} else {
				self.items = response.search ?? [Search]()
			}
			self.notify(.showMovieList)
		case .failure(let error):
			debugPrint(error)
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
	
	public func getMoviePoster(at index: Int, completion: @escaping (UIImage?) -> Void) {
		if let url = items[index].poster {
			service.fetchPoster(url) { (result) in
				switch result {
				case .success(let image):
					completion(image)
				case .failure(_):
					completion(UIImage(named: "popcorn"))
				}
			}
		}
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
