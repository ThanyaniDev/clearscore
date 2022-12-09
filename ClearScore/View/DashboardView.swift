	//
	//  DashboardView.swift
	//  ClearScore
	//
	//  Created by Thanyani Tshikonwani on 2022/12/03.
	//

import SwiftUI

struct DashboardView: View {
	
	@ObservedObject var viewModel: CreditScoreViewModel
	@State var creditScore = 0.0
	@State var animate = false
	
	var body: some View {
		NavigationView {
			ZStack{
				switch viewModel.viewState {
					case .loading:
						VStack {
							Color(.systemBackground)
								.ignoresSafeArea()
							Image("clearscore")
								.resizable()
								.scaledToFit()
								.frame(width: 100.0, height: 100.0)
							ProgressView()
								.progressViewStyle(CircularProgressViewStyle(tint: .black))
								.scaleEffect(2)
						}
						.frame(width: 250, height: 50, alignment: .center)
					case .error(errorMessage: _):
						VStack{
							Text(String.errorSubheader)
								.font(.system(size: 60))
								.fontWeight(.ultraLight)
								.foregroundColor(.black)
							Button(String.tryAgain) {
								Task {
									viewModel.loadCreditScoreData()
								}
							}.font(Font.system(size: 16).bold())
								.frame(width: 250, height: 48)
								.padding([.leading,.trailing], 24)
								. foregroundColor(.white)
								.background(Color.black)
								.cornerRadius(12)
						}
					case .loaded:
						ZStack{
							Circle()
								.stroke(lineWidth: 2)
								.foregroundColor(.gray)
								.opacity(0.1)

							Circle()
								.trim(from: 0.0, to:min(viewModel.score,1.0))
								.stroke(lineWidth: 2)
								.foregroundColor(.black)
								.rotationEffect(.init(degrees: self.animate ? 270 : 0))
								.animation(.easeInOut(duration: 3), value: viewModel.score)
							VStack(spacing: 10) {
								VStack (spacing: 2) {
									Text(String.subHeadLine1)

									Text("\(self.viewModel.scoreData?.creditReportInfo?.score ?? 0)")
										.font(.system(size: 90))
										.fontWeight(.ultraLight)
										.foregroundColor(.yellow)
									Text( .subHeadLine2 + "\(self.viewModel.scoreData?.creditReportInfo?.maxScoreValue ?? 0)")
								}
							}
						}
						.frame(width: 250, height: 250, alignment: .center)
						.padding()
						.navigationTitle( String.navbarTitle)
						.navigationBarTitleDisplayMode(.inline)
				}
			}
		}
		.onAppear {
			UINavigationBarAppearance()
				.setColor(title: .white, background: .black)
			viewModel.loadCreditScoreData()
			self.animate.toggle()
			creditScore =  viewModel.score
		}
	}
}

extension UINavigationBarAppearance {
	func setColor(title: UIColor? = nil, background: UIColor? = nil) {
		configureWithTransparentBackground()
		if let titleColor = title {
			largeTitleTextAttributes = [.foregroundColor: titleColor]
			titleTextAttributes = [.foregroundColor: titleColor]
		}
		backgroundColor = background
		UINavigationBar.appearance().scrollEdgeAppearance = self
		UINavigationBar.appearance().standardAppearance = self
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		let service =  ClearScoreServiceImplementation()
		DashboardView(viewModel: CreditScoreViewModel(clearScoreService: service))
	}
}
