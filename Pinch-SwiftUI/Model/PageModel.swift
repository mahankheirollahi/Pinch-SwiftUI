//
//  PageModel.swift
//  Pinch-SwiftUI
//
//  Created by Mahan Kheirollahi on 7/22/24.
//

import Foundation
struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page{
    var thumbnailName: String{
        return "thumb-" + imageName
    }
}
