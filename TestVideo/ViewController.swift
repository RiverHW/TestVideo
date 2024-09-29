import UIKit
import WebKit

//width
let screenWidth = UIScreen.main.bounds.size.width
let screenHeight = UIScreen.main.bounds.size.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height
let screenFrame:CGRect = UIScreen.main.bounds
let safeAreaTopHeight:CGFloat = (screenHeight >= 812.0 && UIDevice.current.model == "iPhone" ? 88 : 64)
let safeAreaBottomHeight:CGFloat = (screenHeight >= 812.0 && UIDevice.current.model == "iPhone"  ? 30 : 0)

private let reuseIdentifier = "Cell"

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,WKNavigationDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainCollectionView)
        
//        self.loadData()
        
    }
    
    
    // MARK: - Netdata
    
    func loadData() {
        
        view.addSubview(webView)
        webView.backgroundColor = .gray
        
    }
    
    lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
               webConfiguration.allowsInlineMediaPlayback = true
        let web = WKWebView.init(frame: view.bounds, configuration: webConfiguration)
        web.navigationDelegate = self
        let myURL = URL(string: "https://reader.z-library.sk/?source=24f5847423dbd5c4439b64350b41e101dcaf067538c3174f20205c276272d0f6")
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
        return web
    }()
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        let titleMark = "document.getElementsByClassName('weibo-text')[0].textContent"
        
        let contentMark = "document.body.innerHTML"
        
        
        webView.evaluateJavaScript(contentMark) { result, re in
            
            print(result)
        }
    }
    
    
    
    // MARK: - collectionview
    
    lazy var mainCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let collview = UICollectionView.init(frame: CGRect.init(x: 0, y: safeAreaTopHeight, width: screenWidth, height: screenHeight - safeAreaTopHeight - safeAreaBottomHeight - statusBarHeight), collectionViewLayout: layout)
        collview.delegate = self
        collview.dataSource = self
        collview.backgroundColor = UIColor.white
        collview.isPagingEnabled = true
        collview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collview.register(UINib.init(nibName: "TestCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "TestCollectionViewCell")

        return collview
        
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1000
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: "TestCollectionViewCell", for: indexPath) as! TestCollectionViewCell
        cell.cellSetVideo()
        
        if indexPath.row%2 == 0 {
            cell.backgroundColor = .black

        }else{
            cell.backgroundColor = .gray

        }
        
        return cell
    }
    
    // MARK: - UICollectionViewFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

