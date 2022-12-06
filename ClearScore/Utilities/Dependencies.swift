//
//  Dependencies.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import Foundation


class Dependencies {
	init() {
		@Provider var clearScoreService = ClearScoreServiceImplementation() as ClearScoreService
	}
}
