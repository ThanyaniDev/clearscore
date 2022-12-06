//
//  CreditScoreModel.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/04.
//

import Foundation

struct CreditScoreModel: Decodable {
	var creditReportInfo: CreditReportInfo?
}

struct CreditReportInfo: Decodable {
	var score: Int?
	var maxScoreValue: Int?
}
