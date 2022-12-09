//
//  ClearScoreApp.swift
//  ClearScore
//
//  Created by Thanyani Tshikonwani on 2022/12/03.
//

import SwiftUI

@main
struct ClearScoreApp: App {
    var body: some Scene {
        WindowGroup {
			let service =  ClearScoreServiceImplementation()
			DashboardView(viewModel: CreditScoreViewModel(clearScoreService: service))
        }
    }
}
