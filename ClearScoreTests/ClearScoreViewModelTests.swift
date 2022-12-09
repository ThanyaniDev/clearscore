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
	var viewModelUnderTest: CreditScoreViewModel!
	let mockClearScoreService = MockClearScoreService()
	var cancellable = Set<AnyCancellable>()
	
	override func setUpWithError() throws {
		viewModelUnderTest = CreditScoreViewModel(clearScoreService: self.mockClearScoreService)
	}
	
	override func tearDownWithError() throws {
		viewModelUnderTest = nil
	}
	
	func test_ClearScoreViewModel_FetchCreditScore() {
		
		let creditScoreData = CreditScoreModel(creditReportInfo: CreditReportInfo(score:  234, maxScoreValue: 700))
		mockClearScoreService.creditScoreData = creditScoreData
	
		viewModelUnderTest.loadCreditScoreData()
		
		XCTAssertEqual(viewModelUnderTest.scoreData?.creditReportInfo?.score, 234)
		XCTAssertEqual(viewModelUnderTest.scoreData?.creditReportInfo?.maxScoreValue, 700)
	}
		
	func testViewStateIsUpdatedWithErrorWhenFetchingFails() {
		let mockClearScoreService = MockClearScoreService()
		let error = NSError(domain: "Test", code: 0, userInfo: nil)
		mockClearScoreService.error = error
		let viewModel = CreditScoreViewModel(clearScoreService: mockClearScoreService)
	
		viewModel.loadCreditScoreData()
		
		XCTAssertEqual(viewModel.viewState, .error(errorMessage: "\(error)"))
	}
	
	func testScoreIsUpdatedWithCorrectValueWhenFetchingSucceeds() {
		
		let mockClearScoreService = MockClearScoreService()
		let creditScoreData = CreditScoreModel(creditReportInfo: CreditReportInfo(score: NSNumber(value: 700) as? Int,
																				  maxScoreValue: NSNumber(value: 1000) as? Int))
		mockClearScoreService.creditScoreData = creditScoreData
		let viewModel = CreditScoreViewModel(clearScoreService: mockClearScoreService)
		
		viewModel.loadCreditScoreData()
		
		XCTAssertEqual(viewModel.score, 0.7)
	}
}
