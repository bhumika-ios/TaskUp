//
//  PageView.swift
//  TaskUp
//
//  Created by Bhumika Patel on 14/03/23.
//

import SwiftUI

struct PageView: View {
    var page: Page
    var body: some View {
        VStack(spacing: 20) {
            Image("\(page.imageUrl)")
                .resizable()
                .frame(width: 350, height: 300)
            
                .cornerRadius(10)
                .padding(.vertical,80)
            Text(page.name)
                .font(.title).bold()
                .foregroundColor(Color("Primary"))
                .padding(.vertical,-25)
            Text(page.description)
                .bold()
                .foregroundColor(.gray)
                .foregroundColor(Color("Primary"))
                .font(.system(size: 20))
                .frame(width: 300)
//            Image("\(page.imageUrl2)")
//                .resizable()
//                .frame(width: 250, height: 200)
//                .cornerRadius(10)
//               // .padding(.vertical,150)
//            Text(page.name2)
//                .font(.title3).bold()
//                //.padding()
//            Text(page.description2)
//                .bold()
//                .foregroundColor(.gray)
//                .font(.system(size: 14))
//                .frame(width: 300)
        }
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage)
    }
}
