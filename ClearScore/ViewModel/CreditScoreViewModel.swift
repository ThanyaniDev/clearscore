//
//  CreditScoreViewModel.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/04.
//

import Foundation
import Combine
import SwiftUI

class CreditScoreViewModel: ObservableObject {
	
	@Inject private var clearScoreService: ClearScoreService
	
	@Published var scoreData: CreditScoreModel?
	@Published var score: Double = 0.0
	@Published var viewState:CreditScoreViewState=CreditScoreViewState.initial
	
	private var cancellables = Set<AnyCancellable>()
		
	func loadCreditScoreData() {
		viewState = CreditScoreViewState.loading
		clearScoreService.fetchCreditScore()
			.sink(receiveCompletion: { [weak self] completion in
				switch completion {
					case .failure(let error):
						self?.viewState = CreditScoreViewState.error(errorMessage: "\(error)")
					case .finished:
						break
				}
			}, receiveValue: { [weak self] creditScoreData in
				self?.viewState = CreditScoreViewState.loaded
				self?.scoreData =  creditScoreData
				self?.score = (( creditScoreData.creditReportInfo?.score?.doubleValue ?? 0.0) / (creditScoreData.creditReportInfo?.maxScoreValue?.doubleValue ?? 0.0))
			}).store(in: &cancellables)
	}
}
