//
//  MovieSearchListViewController.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class MovieSearchListViewController: UIViewController {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var movieTypesSegment: UISegmentedControl!
	@IBOutlet weak var yearTextField: UITextField!
	
	var searchTask: DispatchWorkItem?
	let yearPicker = ToolbarPickerView()
	var yearPickerDataSource = [String]()
	
	var viewModel: MovieSearchListViewModelProtocol! {
		didSet {
			viewModel.delegate = self
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		yearPickerDataSource.append("Any Year")
		yearPickerDataSource.append(contentsOf: Array(1890...2020).reversed().map { "\($0)" })
		yearTextField.inputView = yearPicker
		yearTextField.inputAccessoryView = yearPicker.toolbar
		yearPicker.dataSource = self
		yearPicker.delegate = self
		yearPicker.toolbarDelegate = self
		yearPicker.reloadAllComponents()
		searchBar.delegate = self
		title = "Search in OMDB"
		searchBar.becomeFirstResponder()
	}
	
	@IBAction func movieTypesDidChange(_ sender: UISegmentedControl) {
		search()
	}
	
	func search() {
		if let task = searchTask {
			task.cancel()
			searchTask = nil
		}
		let task = DispatchWorkItem { [weak self] in
			guard let self = self else { return }
			self.sendSearchRequest()
		}
		self.searchTask = task
		DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75, execute: task)
	}
	
	func sendSearchRequest() {
		if !searchBar.text.isNilOrEmpty && searchBar.text!.count > 2 {
			if movieTypesSegment.selectedSegmentIndex > 0 {
				let type = movieTypesSegment.titleForSegment(at: movieTypesSegment.selectedSegmentIndex) ?? ""
				if yearTextField.text != "Any Year" {
					viewModel.search(by: searchBar.text!, year: yearTextField.text!, type: type)
				} else {
					viewModel.search(by: searchBar.text!, type: type)
				}
			} else {
				viewModel.search(by: searchBar.text!, year: yearTextField.text!)
			}
		}
	}
}

extension MovieSearchListViewController: UISearchBarDelegate {
	
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		search()
	}
	
}

extension MovieSearchListViewController: UIPickerViewDelegate, UIPickerViewDataSource, ToolbarPickerViewDelegate {
	
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return yearPickerDataSource.count
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return yearPickerDataSource[row]
	}
	
	func didTapDone() {
		let row = yearPicker.selectedRow(inComponent: 0)
		yearPicker.selectRow(row, inComponent: 0, animated: false)
		yearTextField.text = yearPickerDataSource[row]
		yearTextField.resignFirstResponder()
		search()
	}
	
	func didTapCancel() {
		yearTextField.resignFirstResponder()
	}
}

extension MovieSearchListViewController: MovieSearchListViewModelDelegate {
	
	func handleViewModelOutput(_ output: MovieSearchListViewModelOutput) {
		switch output {
		case .setLoading(let isLoading):
			UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
		case .showMovieList:
			tableView.reloadData()
		}
	}
	
	func navigate(to route: MovieSearchListViewRoute) {
		switch route {
		case .detail(let viewModel):
			let viewController = MovieDetailBuilder.make(with: viewModel)
			show(viewController, sender: nil)
		}
	}
	
}

extension MovieSearchListViewController: UITableViewDelegate {
	
	func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
		let offsetY = scrollView.contentOffset.y
		let contentHeight = scrollView.contentSize.height
		if offsetY > contentHeight - scrollView.frame.size.height {
			viewModel.loadMore()
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		viewModel.selectMovie(at: indexPath.row)
	}
	
}

extension MovieSearchListViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let number = viewModel.getNumberOfItems()
		if searchBar.text.isNilOrEmpty {
			tableView.setEmptyView(title: "Please Search", message: "Search for movies")
		} else if number == 0 {
			tableView.setEmptyView(title: "Oops...", message: "There is no result for given search parameters")
		} else {
			tableView.restore()
		}
		return number
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieSearchItem", for: indexPath) as? MovieSearchListCell else {
			fatalError("could not dequeue tableViewCell")
		}
		cell.titleLabel.text = viewModel.getMovieTitle(at: indexPath.row)
		cell.yearLabel.text = viewModel.getMovieYear(at: indexPath.row)
		cell.itemTypeLabel.text = viewModel.getMovieType(at: indexPath.row)
		viewModel.getMoviePoster(at: indexPath.row) { (image) in
			cell.posterView.image = image
		}
		return cell
	}
	
}
