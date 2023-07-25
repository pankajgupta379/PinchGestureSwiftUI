//
//  PageModel.swift
//  PinchGestureDemo
//
//  Created by Pankaj Gupta on 11/06/23.
//

import Foundation

struct Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbNailImage: String {
        return "thumb-" + imageName
    }
}
