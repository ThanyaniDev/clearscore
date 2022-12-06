//
//  ClearScoreServiceTests.swift
//  ClearScoreTests
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import XCTest
import Combine
@testable import ClearScore

class ClearScoreServiceTests: XCTestCase {
	
	private var cancellable = Set<AnyCancellable>()
	
	override func tearDownWithError() throws {
		cancellable.removeAll()
	}
	
	func test_MockClearScoreService_FetchCreditScore_doesReturnValues() {
		let mockClearScoreService = MockClearScoreService(items: CreditScoreModel.init(creditReportInfo: CreditReportInfo(score: 300, maxScoreValue: 500)))
		let expectation = XCTestExpectation()
		
		var score: CreditScoreModel?
		
		mockClearScoreService.fetchCreditScore()
			.sink { completion in
				switch completion {
					case .finished:
						expectation.fulfill()
					case .failure:
						XCTFail()
				}
			} receiveValue: { returnedScore in
				score = returnedScore
			}
			.store(in: &cancellable)
			
		wait(for: [expectation], timeout: 2)
		XCTAssertEqual(score?.creditReportInfo?.score, mockClearScoreService.items.creditReportInfo?.score)
		XCTAssertEqual(score?.creditReportInfo?.maxScoreValue, mockClearScoreService.items.creditReportInfo?.maxScoreValue)
	}
}
