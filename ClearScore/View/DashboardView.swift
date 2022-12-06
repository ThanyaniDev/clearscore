	//
	//  DashboardView.swift
	//  ClearScore
	//
	//  Created by Thanyani Tshikonwani on 2022/12/03.
	//

import SwiftUI

struct DashboardView: View {
	
	@StateObject var vm: CreditScoreViewModel =  CreditScoreViewModel()
	@State var creditScore = 0.0
	
	var body: some View {
		
		NavigationView {
			ZStack{
				switch vm.viewState {
					case .initial:
						ProgressView()
					case .loading:
						ProgressView()
					case .error(errorMessage: _):
						VStack{
							Text(String.errorSubheader)
								.font(.system(size: 60))
								.fontWeight(.ultraLight)
								.foregroundColor(.black)
							Button(String.tryAgain) {
								Task {
									vm.loadCreditScoreData()
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
							Rectangle()
								.frame(height: 0)
								.background(Color.green.opacity(0.2))
							Circle()
								.stroke(lineWidth: 2)
								.foregroundColor(.gray)
								.opacity(0.1)

							Circle()
								.trim(from: 0.0, to:min(vm.score,1.0))
								.stroke(lineWidth: 2)
								.foregroundColor(.black)
								.rotationEffect(Angle(degrees: 270))
								.animation(.easeInOut(duration: 1).delay(1), value: vm.score)
								
							VStack(spacing: 10) {
								VStack (spacing: 2) {
									Text(String.subHeadLine1)

									Text("\(self.vm.scoreData?.creditReportInfo?.score ?? 0)")
										.font(.system(size: 90))
										.fontWeight(.ultraLight)
										.foregroundColor(.yellow)
									Text( .subHeadLine2 + "\(self.vm.scoreData?.creditReportInfo?.maxScoreValue ?? 0)")
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
			vm.loadCreditScoreData()
			creditScore =  vm.score
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
		DashboardView()
	}
}
