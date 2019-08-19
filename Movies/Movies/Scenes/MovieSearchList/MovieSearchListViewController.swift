//
//  MovieSearchListViewController.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class MovieSearchListViewController: UIViewController {
	
	 var viewModel: MovieSearchListViewModelProtocol!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		app.service.searchMovies { (response) in
			debugPrint(response)
			debugPrint("==================================================")
		}
		
		app.service.fetchMovieDetailByTitle("superman") { (response) in
			debugPrint(response)
			debugPrint("==================================================")
		}
		
	}
}
