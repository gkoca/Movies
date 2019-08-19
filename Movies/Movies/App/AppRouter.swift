//
//  AppRouter.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import UIKit

final class AppRouter {
	
	let window: UIWindow
	
	init() {
		window = UIWindow(frame: UIScreen.main.bounds)
	}
	
	func start() {
		let viewController = MovieSearchListBuilder.make()
		let navigationController = UINavigationController(rootViewController: viewController)
		window.rootViewController = navigationController
		window.makeKeyAndVisible()
	}
}
