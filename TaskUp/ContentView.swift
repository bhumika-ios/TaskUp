//
//  ContentView.swift
//  TaskUp
//
//  Created by Bhumika Patel on 14/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var pageIndex = 0
    private let pages: [Page] = Page.samplePages
    private let dotAppearance = UIPageControl.appearance()
    
    var body: some View {
        TabView(selection: $pageIndex) {
            ForEach(pages) { page in
                VStack {
                    Spacer()
                    PageView(page: page)
                    Spacer()
                    if page == pages.last {
                        Button("Get Start", action: goToZero)
                            .bold()
                            .frame(width: 150, height: 25)
                            .foregroundColor(Color("Secondary"))
                            .padding(.vertical, 12)
                            .padding(.horizontal)
                            .background(.black, in: Capsule())
                    }
                       
//                    else {
//                        Button(action: incrementPage){
//                            Image(systemName: "chevron.right").bold()
//                        }
//                        .foregroundColor(Color("Primary"))
//                        .offset(x:150, y:55)
//                    }
                        
                       
                    Spacer()
                       
                }
                .tag(page.tag)
                
            }
        }
        .animation(.easeInOut, value: pageIndex)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .interactive))
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .black
            dotAppearance.pageIndicatorTintColor = UIColor(named: "GrayLight")
        }
    }
    func incrementPage() {
        pageIndex += 1
    }
    func goToZero() {
        pageIndex = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
