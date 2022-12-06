//
//  Enum.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import Foundation

enum CreditScoreViewState {
	case initial
	case loading
	case loaded
	case error(errorMessage:String)
	
}
