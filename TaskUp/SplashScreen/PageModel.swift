//
//  PageModel.swift
//  TaskUp
//
//  Created by Bhumika Patel on 14/03/23.
//

import Foundation

struct Page: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
 
    var imageUrl: String
   
    var tag: Int
    
    static var samplePage = Page(
        name: "Title Example",
        description: "This is a sample description for the purpose of debugging",
        imageUrl: "task8",
        tag: 0
    )
    
    static var samplePages: [Page] = [
        Page(
            name: "Without TaskUp",
            description: "Lazy Work",
            imageUrl: "task9",
            tag: 0
        ),
        Page(
            name: "With TaskUp",
            description: "Smart Work",
            imageUrl: "task8",
            tag: 1
        ),
        Page(
            name: "TaskUp",
            description: "Step By Step Process",
            imageUrl: "Task4",
            tag: 1
        ),
    ]
    
}
