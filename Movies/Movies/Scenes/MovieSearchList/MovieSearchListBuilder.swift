//
//  MovieSearchListBuilder.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class MovieSearchListBuilder {
	
	static func make() -> MovieSearchListViewController {
		let storyboard = UIStoryboard(name: "MovieSearchList", bundle: nil)
		if let viewController = storyboard.instantiateViewController(withIdentifier: "MovieSearchListViewController") as? MovieSearchListViewController {
			viewController.viewModel = MovieSearchListViewModel()
			return viewController
		} else {
			fatalError("MovieSearchListViewController could not instantiate")
		}
	}
}
