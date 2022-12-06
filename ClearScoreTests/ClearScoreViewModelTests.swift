//
//  ClearScoreViewModelTests.swift
//  ClearScoreTests
//
//  Created by Thanyani Tshikonwani on 2022/12/06.
//

import XCTest
import Combine
@testable import ClearScore

class ClearScoreViewModelTests: XCTestCase {
	var viewModelUndetTest: CreditScoreViewModel?
	var cancellable = Set<AnyCancellable>()
	
	override func setUpWithError() throws {
		viewModelUndetTest = CreditScoreViewModel()
	}
	
	override func tearDownWithError() throws {
		viewModelUndetTest = nil
	}
	
	func test_ClearScoreViewModel_FetchCreditScore() {
		let scoreData =  CreditScoreModel.init(creditReportInfo: CreditReportInfo(score: 514, maxScoreValue: 700))
		let expectation = XCTestExpectation(description: "Should return items after a second.")
		viewModelUndetTest?.$scoreData
			.dropFirst()
			.sink {
				returnedScoreData in
				expectation.fulfill()
			}.store(in: &cancellable)
		
		viewModelUndetTest?.loadCreditScoreData()
		
		wait(for: [expectation], timeout: 2)
		XCTAssertEqual(viewModelUndetTest?.scoreData?.creditReportInfo?.score, scoreData.creditReportInfo?.score)
		XCTAssertEqual(viewModelUndetTest?.scoreData?.creditReportInfo?.maxScoreValue, scoreData.creditReportInfo?.maxScoreValue)
	}
}
