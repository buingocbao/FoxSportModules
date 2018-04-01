//
//  LinkFactory.swift
//  FoxSportModules
//
//  Created by BimBim on 3/29/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import Foundation

class LinkFactory {

    static let facebookPostLink = "https://www.facebook.com/bbaobao.22/posts/1854062254613008"

    static func generateCommentsHTMLString(width: Int, numberPosts: Int) -> String {
        return
"""
        <!DOCTYPE html>
        <html>
        <head>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
        </head>
        <body>
        <div id="fb-root"></div>
        <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = 'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.12&appId=2151596891730525';
        fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));</script>
        <div class="fb-comments" data-href="https://www.facebook.com/bbaobao.22/posts/1847861405233093" data-width="\(width)" data-numposts="\(numberPosts)"></div>
        </body>
        </html>
"""
    }

    static func generateLinkList() -> [String] {
        return ["https://www.google.com.vn", "https://www.tinhte.vn",
         "https://www.medium.com", "https://www.youtube.com",
         "https://mp3.zing.vn", "http://2359media.com"]
    }
}
