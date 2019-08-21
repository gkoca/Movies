//
//  MovieDetailViewController.swift
//  Movies
//
//  Created by Gökhan KOCA on 21.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class MovieDetailViewController: UITableViewController {
	
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var directorLabel: UILabel!
	@IBOutlet weak var writerLabel: UILabel!
	@IBOutlet weak var actorsLabel: UILabel!
	@IBOutlet weak var plotLabel: UILabel!
	@IBOutlet weak var genreLabel: UILabel!
	@IBOutlet weak var ratedLabel: UILabel!
	@IBOutlet weak var releasedLabel: UILabel!
	@IBOutlet weak var runtimeLabel: UILabel!
	@IBOutlet weak var languageLabel: UILabel!
	@IBOutlet weak var countryLabel: UILabel!
	@IBOutlet weak var awardsLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	@IBOutlet weak var DVDLabel: UILabel!
	@IBOutlet weak var boxOfficeLabel: UILabel!
	@IBOutlet weak var productionLabel: UILabel!
	@IBOutlet weak var websiteLabel: UILabel!
	@IBOutlet weak var ratingsLabel: UILabel!
	
	var viewModel: MovieDetailViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		titleLabel.text = "N/A"
		directorLabel.text = "N/A"
		writerLabel.text = "N/A"
		actorsLabel.text = "N/A"
		plotLabel.text = "N/A"
		genreLabel.text = "N/A"
		ratedLabel.text = "N/A"
		releasedLabel.text = "N/A"
		runtimeLabel.text = "N/A"
		languageLabel.text = "N/A"
		countryLabel.text = "N/A"
		awardsLabel.text = "N/A"
		typeLabel.text = "N/A"
		DVDLabel.text = "N/A"
		boxOfficeLabel.text = "N/A"
		productionLabel.text = "N/A"
		websiteLabel.text = "N/A"
		ratingsLabel.text = "N/A"
		posterImageView.image = UIImage(named: "popcorn")
	}
	
}

extension MovieDetailViewController: MovieDetailViewModelDelegate {
	
	func showDetail() {
		viewModel.getMoviePoster { [weak self] image in
			guard let self = self else { return }
			self.posterImageView.image = image
		}
		titleLabel.text = viewModel.getMovieTitle()
		directorLabel.text = viewModel.getMovieDirector()
		writerLabel.text = viewModel.getMovieWriter()
		actorsLabel.text = viewModel.getMovieActors()
		plotLabel.text = viewModel.getMoviePlot()
		genreLabel.text = viewModel.getMovieGenre()
		ratedLabel.text = viewModel.getMovieRated()
		releasedLabel.text = viewModel.getMovieReleased()
		runtimeLabel.text = viewModel.getMovieRuntime()
		languageLabel.text = viewModel.getMovieLanguage()
		countryLabel.text = viewModel.getMovieCountry()
		awardsLabel.text = viewModel.getMovieAwards()
		typeLabel.text = viewModel.getMovieType()
		DVDLabel.text = viewModel.getMovieDVD()
		boxOfficeLabel.text = viewModel.getMovieBoxOffice()
		productionLabel.text = viewModel.getMovieProduction()
		websiteLabel.text = viewModel.getMovieWebsite()
		ratingsLabel.text = viewModel.getMovieRatings()
		tableView.reloadData()
	}
	
}

extension MovieDetailViewController {
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if cell.reuseIdentifier == "titleCell" {
			self.title = ""
		}
	}
	
	override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if cell.reuseIdentifier == "titleCell" {
			self.title = titleLabel.text
		}
	}
	
}
