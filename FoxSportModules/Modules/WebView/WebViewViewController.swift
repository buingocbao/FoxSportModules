//
//  WebViewViewController.swift
//  FoxSportModules
//
//  Created by BimBim on 3/27/18.
//  Copyright © 2018 BimBim. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    var viewModel = WebviewViewModel(links: LinkFactory.generateLinkList())
    
    var webView: WKWebView!

    var request: URLRequest?

    private var currentLinkIndex: Int = -1 { didSet { didChangeCurrentLinkIndex() } }

    override func loadView() {
        super.loadView()
        webView = WKWebView(frame: containerView.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.allowsBackForwardNavigationGestures = true
        webView.allowsLinkPreview = true
        containerView.addSubview(webView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentLinkIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var controlView: UIView!

    @IBOutlet weak var commentTouchArea: UIButton!
    @IBOutlet weak var commentLabel: UILabel!

    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!

    @IBOutlet weak var shareButton: UIButton!
}

// MARK: Delegates
extension WebViewViewController: WKUIDelegate, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }

    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        print("runJavaScriptAlertPanelWithMessage")
        print(message)
    }

    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        print("runJavaScriptConfirmPanelWithMessage")
        print(message)
    }

    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        print("runJavaScriptTextInputPanelWithPrompt")
        print(prompt)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let actionStr = navigationAction.request.url?.absoluteString else {
            decisionHandler(.allow)
            return
        }
        if actionStr.contains("from_login=1") {
            renderWebView()
        }
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }

    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame?.isMainFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
}

// MAKR: Handler functions
extension WebViewViewController {
    func didChangeCurrentLinkIndex() {
        renderWebView()
        renderControls()
    }

    func renderWebView() {
        switch viewModel.type {
        case .link:
            loadURL()
        case .fbcomment:
            loadFbComment()
        }
    }

    func loadFbComment() {
        guard let url = viewModel.getFacebookCommentURL() else { return }

        loadBlankWebview()

        request = URLRequest(url: url)
        guard let request = request else { return }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            self?.webView?.load(request)
        }
    }

    func loadURL() {
        guard viewModel.numberOfLinks != 0 else { return }
        loadBlankWebview()

        self.controlView.isHidden = viewModel.numberOfLinks == 1

        guard viewModel.links.startIndex..<viewModel.links.endIndex ~= currentLinkIndex,
            let url = URL(string: viewModel.links[currentLinkIndex]) else { return }
        request = URLRequest(url: url)

        guard let request = request else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            self?.webView?.load(request)
        }
    }

    func loadBlankWebview() {
        webView?.loadHTMLString("", baseURL: nil)
    }

    func renderControls() {
        switch viewModel.type {
        case .link:
            controlView.isHidden = viewModel.numberOfLinks == 1
        case .fbcomment:
            controlView.isHidden = true
        }
        switch currentLinkIndex {
        case 0:
            previousButton.isEnabled = false
        case 1..<viewModel.links.endIndex-2:
            previousButton.isEnabled = true
            nextButton.isEnabled = true
        case viewModel.links.endIndex-1:
            nextButton.isEnabled = false
        default:
            break
        }
    }
}

// MARK: Actions
extension WebViewViewController {
    @IBAction func commentTapped(_ sender: UIButton) {
        let commentViewController = UIStoryboard.init(name: "Webview", bundle: nil).instantiateViewController(withIdentifier: "WebviewViewController") as! WebViewViewController
        commentViewController.viewModel = WebviewViewModel(links: [LinkFactory.facebookPostLink],
                                                           type: .fbcomment)
        self.navigationController?.pushViewController(commentViewController, animated: true)
    }

    @IBAction func previousTapped(_ sender: UIButton) {
        currentLinkIndex -= 1
    }

    @IBAction func nextTapped(_ sender: UIButton) {
        currentLinkIndex += 1
    }

    @IBAction func shareTapped(_ sender: UIButton) {
        guard viewModel.links.startIndex..<viewModel.links.endIndex ~= currentLinkIndex else { return }
        guard let url = URL(string: viewModel.links[currentLinkIndex]) else { return }
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        self.present(activityViewController, animated: true, completion: nil)
    }
}
