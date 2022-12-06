//
//  Mocks.swift
//  ClearScoreTests
//
//  Created by Thanyani Tshikonwani on 2022/12/05.
//

import Foundation
import Combine
@testable import ClearScore

final class MockClearScoreService: ClearScoreService {
	
	
	let items: CreditScoreModel
	
	init(items: CreditScoreModel) {
		self.items = items 
	}

	func fetchCreditScore() -> AnyPublisher<CreditScoreModel, Error> {
		Just(items)
			.setFailureType(to: Error.self)
			.eraseToAnyPublisher()
	}
}

