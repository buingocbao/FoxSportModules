//
//  WebviewViewModel.swift
//  FoxSportModules
//
//  Created by BimBim on 3/29/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

enum WebViewType {
    case link
    case fbcomment
}

class WebviewViewModel {

    // Input
    var links: [String] = []
    var type: WebViewType

    let fbCommentLink = "http://nms.foxplayasia.com/view/comment"

    //
    var numberOfLinks: Int {
        return links.count
    }

    init(links: [String], type: WebViewType = .link) {
        self.links = links
        self.type = type
    }
}

extension WebviewViewModel {
    func getFacebookCommentURL() -> URL? {
        guard let href = links.first else { return nil}
        let fbCommentURL = String(format: "%@?guid=%@", fbCommentLink, href)
        return URL(string: fbCommentURL)
    }
}
