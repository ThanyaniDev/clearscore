//
//  Mocks.swift
//  ClearScoreTests
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import Foundation
import Combine
@testable import ClearScore

class MockClearScoreService: ClearScoreService {
	var creditScoreData: CreditScoreModel?
	var error: Error?
	
	func fetchCreditScore() -> AnyPublisher<CreditScoreModel, Error> {
		if let creditScoreData = creditScoreData {
			return Result.success(creditScoreData)
				.publisher
				.eraseToAnyPublisher()
		} else if let error = error {
			return Result.failure(error)
				.publisher
				.eraseToAnyPublisher()
		} else {
			fatalError("No data or error specified")
		}
	}
}



