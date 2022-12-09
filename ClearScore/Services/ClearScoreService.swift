//
//  ClearScoreService.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/04.
//

import Foundation
import Combine

protocol ClearScoreService {
	func fetchCreditScore() -> AnyPublisher<CreditScoreModel, Error>
}

class ClearScoreServiceImplementation: ClearScoreService {
	func fetchCreditScore() -> AnyPublisher<CreditScoreModel, Error> {

		guard let url =  URL(string: String.getEventsUrl)
		else {  let error = URLError(.badServerResponse)
			return Fail(error: error)
			.eraseToAnyPublisher() }

		return URLSession.shared.dataTaskPublisher(for: url)
			.tryMap({ data, response in
				guard let httpResponse = response as? HTTPURLResponse else {
					throw URLError(.unknown)
				}
				guard httpResponse.statusCode == 200 else {
					let code = URLError.Code(rawValue: httpResponse.statusCode)
					throw URLError(code)
				}
				return data
			})
			.decode(type: CreditScoreModel.self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}


