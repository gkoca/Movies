//
//  AppContainer.swift
//  Movies
//
//  Created by Gökhan KOCA on 19.08.2019.
//  Copyright © 2019 gkoca. All rights reserved.
//

import Foundation
import OMDBApi

let app = AppContainer()

final class AppContainer {
	
	let router = AppRouter()
	let service = OMDBApiService()
	
}
