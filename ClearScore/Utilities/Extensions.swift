//
//   Extensions.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/04.
//

import Foundation


extension String {
	static let getEventsUrl = "https://5lfoiyb0b3.execute-api.us-west-2.amazonaws.com/prod/mockcredit/values"
	static let subHeadLine1 = "Your credit score is"
	static let subHeadLine2 = "out of "
	static let navbarTitle = "Dashboard"
	static let tryAgain = "Try Again"
	static let errorSubheader = "Something went wrong!"
}

extension Int {
	var doubleValue: Double {
		return Double(self)
	}
}
