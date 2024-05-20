//
//  PageView.swift
//  ArbuzClone
//
//  Created by Rauan on 20.05.2024.
//

import SwiftUI

struct ScreenView: View {
    let backgroundColor : Color = Color(red: 244/255, green: 205/255, blue: 110/255)
    
    @AppStorage("currentPage") var currentPage = 1
    @State private var progress = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    var image: String
    var title: String
    var detail: String

    var body: some View {
        VStack(spacing: 10) {
            progressBar
                .padding(.top, 70)
            navigationBarView
                .padding(.horizontal, 20)
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .foregroundColor(.green)
            
            Text(detail)
                .font(.body)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 20)
                .frame(maxHeight: 400)
            Spacer(minLength: 0)
            navigationButton
                .padding(.bottom, 50)
        }
        .onReceive(timer) { _ in
            if currentPage < totalPages {
                if progress < 1.0 {
                    progress += 0.05
                } else {
                    progress = 0.0
                    currentPage += 1
                }
            } else if progress < 1.0 {
                progress += 0.05
            }
        }
        .background(backgroundColor)
        .edgesIgnoringSafeArea(.all)
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    var navigationBarView: some View {
        HStack {
            if currentPage == 1 {
                Text("Arbuz kz")
                    .font(.title)
                    .fontWeight(.semibold)
                    .kerning(1.4)
            } else {
                Button {
                    currentPage -= 1
                    progress = 0.0
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .background(Color.white.opacity(0.4))
                        .cornerRadius(10)
                }
            }
            Spacer()
            Button {
                currentPage = 3
            } label: {
                Text("Пропустить")
                    .fontWeight(.semibold)
                    .kerning(1.2)
            }
        }
        .foregroundColor(.black)
    }
    
    var progressBar: some View {
        HStack(spacing: 10) {
            ForEach(0..<totalPages, id: \.self) { index in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 5)
                        .foregroundColor(index < currentPage - 1 ? Color.white : Color.gray)
                    if index == currentPage - 1 {
                        Rectangle()
                            .frame(width: CGFloat(progress) * (UIScreen.main.bounds.width / CGFloat(totalPages) - 15), height: 5)
                            .foregroundColor(Color.white)
                            .animation(.linear, value: progress)
                    }
                }
                .frame(width: UIScreen.main.bounds.width / CGFloat(totalPages) - 15, height: 8)
            }
        }
        
    }

    var navigationButton: some View {
        Button {
            if currentPage < totalPages {
                currentPage += 1
                progress = 0.0
            } else {
                currentPage += 1
            }
        } label: {
            Text(currentPage == totalPages ? "Начать покупки" : "Продолжить")
                .fontWeight(.semibold)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(10)
                .padding(.horizontal, 16)
        }
    }
}

#Preview {
    ScreenView(image: "onboarding", title: "food", detail: "ffjfjfjf")
}
