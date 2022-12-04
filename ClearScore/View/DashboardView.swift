	//
	//  DashboardView.swift
	//  ClearScore
	//
	//  Created by Thanyani Tshikonwani on 2022/12/03.
	//

import SwiftUI

struct DashboardView: View {
	@State var creditScore = 0.0
	@State var maxCreditScore = 700
	
	var body: some View {
		NavigationView {
			
			ZStack{
				Rectangle()
					.frame(height: 0)
					.background(Color.green.opacity(0.2))
				Circle()
					.stroke(lineWidth: 2)
					.foregroundColor(.gray)
					.opacity(0.1)
				
				Circle()
					.trim(from: 0.0, to:min(creditScore,1.0))
					.stroke(lineWidth: 2)
					.foregroundColor(.black)
					.rotationEffect(Angle(degrees: 90))
					.animation(.easeInOut(duration: 1.0), value: creditScore)
				
				VStack(spacing: 10) {
					VStack (spacing: 2) {
						Text("Your credit score is")
						
						Text("327")
							.font(.largeTitle)
							.fontWeight(.ultraLight)
							.foregroundColor(.yellow)
						Text("out of \(maxCreditScore)")
					}
				}
			}
			.frame(width: 250, height: 250, alignment: .center)
			.padding()
			.onAppear {
				creditScore =  514.0/700.0
			}
			.navigationTitle("Dashboard")
			.navigationBarTitleDisplayMode(.inline)
		}
		.onAppear {
			UINavigationBarAppearance()
				.setColor(title: .white, background: .black)
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
