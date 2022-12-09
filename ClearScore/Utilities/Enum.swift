//
//  Enum.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import Foundation

enum CreditScoreViewState: Equatable {
	case loading
	case error(errorMessage: String)
	case loaded
	
		// Implement the == operator function
	static func ==(lhs: CreditScoreViewState, rhs: CreditScoreViewState) -> Bool {
		switch (lhs, rhs) {
			case (.loading, .loading):
				return true
			case let (.error(errorMessage: lhsErrorMessage), .error(errorMessage: rhsErrorMessage)):
				return lhsErrorMessage == rhsErrorMessage
			case (.loaded, .loaded):
				return true
			default:
				return false
		}
	}
}
