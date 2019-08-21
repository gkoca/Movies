//
//  MovieDetailBuilder.swift
//  Movies
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class MovieDetailBuilder {
	static func make(with viewModel: MovieDetailViewModelProtocol) -> MovieDetailViewController {
		let storyboard = UIStoryboard(name: "MovieDetail", bundle: nil)
		guard let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
			fatalError("MovieDetailViewController could not instantiate")
		}
		viewController.viewModel = viewModel
		return viewController
	}
}
