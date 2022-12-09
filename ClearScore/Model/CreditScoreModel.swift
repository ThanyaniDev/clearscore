//
//  CreditScoreModel.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/04.
//

import Foundation

struct CreditScoreModel: Decodable, Equatable {
	var creditReportInfo: CreditReportInfo?
	
	static func == (lhs: CreditScoreModel, rhs: CreditScoreModel) -> Bool {
		return lhs.creditReportInfo == rhs.creditReportInfo
	}
}

struct CreditReportInfo: Decodable, Equatable {
	var score: Int?
	var maxScoreValue: Int?
	
	static func == (lhs: CreditReportInfo, rhs: CreditReportInfo) -> Bool {
		return lhs.score == rhs.score && lhs.maxScoreValue == rhs.maxScoreValue
	}
}

