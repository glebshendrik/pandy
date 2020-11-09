//
//  Page.swift
//  pandy
//
//  Created by Gleb Shendrik on 16.07.2020.
//

import Foundation

struct Page {
    let page: Int
    
    private init(page: Int) {
        self.page = page
    }
}

extension Page {
    static var first: Page {
        return Page(page: 1)
    }
    
    var next: Page {
        return Page(page: page + 1)
    }
    
    var isFirst: Bool {
        return page == 0
    }
}
