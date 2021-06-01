import UIKit
import Flutter
import google_mobile_ads
import MobileCoreServices
import GoogleMobileAds
import Foundation
import Firebase


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UIDocumentPickerDelegate,
                         UIDocumentBrowserViewControllerDelegate, GADFullScreenContentDelegate{
    
    var fileUrl = "";
    var behavior_path:URL?;
    var resource_path:URL?;
    var addon_name:String?;
    var result: FlutterResult?
    var documentInteractionController:UIDocumentInteractionController?
    
    var appOpenAd:GADAppOpenAd?
    var loadTime:Date?
    var isNotFirst:Bool = false;
    
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let get_channel = FlutterMethodChannel(name: "addons/detail", binaryMessenger: controller.binaryMessenger)

    get_channel.setMethodCallHandler({
         (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        if(call.method == "install"){
            self.result = result;
            self.fileUrl = call.arguments as! String
            let fileUrl = URL(fileURLWithPath: self.fileUrl)
            let docUrl = fileUrl.deletingPathExtension()
            self.addon_name = self.fileUrl.fileName()

            let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]

            guard let fileList =
                FileManager.default.enumerator(at: docUrl, includingPropertiesForKeys: keys) else {
                    return
            }
            
            for case let file as URL in fileList {
                // Also start accessing the content's security-scoped URL.
                if file.absoluteString.hasSuffix("resource_pack/") { // true
                    self.resource_path = file
                    print(file)
                }
                
                if file.absoluteString.hasSuffix("behavior_pack/") { // true
                    self.behavior_path = file
                    print(file)
                }
            }
        
          let appScheme = "minecraft://"
          let appUrl = URL(string: appScheme)
          if UIApplication.shared.canOpenURL(appUrl! as URL){

            if #available(iOS 13.3.1, *) {
              let temporaryDirectoryPath = NSTemporaryDirectory()
              let tmpDir = URL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
                let tmpUrl = tmpDir.appendingPathComponent(URL(fileURLWithPath: self.fileUrl).lastPathComponent)
              do {
                  if FileManager.default.fileExists(atPath: tmpUrl.path) {
                      try FileManager.default.removeItem(at: tmpUrl)
                  }
                try FileManager.default.copyItem(at: URL(fileURLWithPath: self.fileUrl), to: tmpUrl)
                    print(tmpUrl);
                self.documentInteractionController = UIDocumentInteractionController(url: tmpUrl)
                self.documentInteractionController!.uti = "com.mojang.minecraftpe"
                self.documentInteractionController!.presentOpenInMenu(from: CGRect.zero, in: controller.view, animated: true)
              } catch let error {
                  print("Cannot copy item at \(docUrl) to \(tmpUrl): \(error)")
              }
            }else if #available(iOS 13.0, *) {
                self.showPickerView();
            }else if #available(iOS 11.2, *) {
                  let temporaryDirectoryPath = NSTemporaryDirectory()
                  let tmpDir = URL(fileURLWithPath: temporaryDirectoryPath, isDirectory: true)
                    let tmpUrl = tmpDir.appendingPathComponent(URL(fileURLWithPath: self.fileUrl).lastPathComponent)
                  do {
                      if FileManager.default.fileExists(atPath: tmpUrl.path) {
                          try FileManager.default.removeItem(at: tmpUrl)
                      }
                    try FileManager.default.copyItem(at: URL(fileURLWithPath: self.fileUrl), to: tmpUrl)
                        print(tmpUrl);
                    self.documentInteractionController = UIDocumentInteractionController(url: tmpUrl)
                    self.documentInteractionController!.uti = "com.mojang.minecraftpe"
                    self.documentInteractionController!.presentOpenInMenu(from: CGRect.zero, in: controller.view, animated: true)
                  } catch let error {
                      print("Cannot copy item at \(docUrl) to \(tmpUrl): \(error)")
                  }
              } else {
               result(true)
            }
          }else{
            result(false)
          }
        }else if(call.method == "check1331"){
        if #available(iOS 13.3.1, *) {
            result(true)
        }else{
            result(false)
        }
        }else{
        result(FlutterMethodNotImplemented)
        }
        })
    FirebaseApp.configure()
    
    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false
    
    GeneratedPluginRegistrant.register(with: self)
    
    let nativeAdFactory = NativeAdFactoryAddon()
    FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        self,
        factoryId: "adFactoryId",
        nativeAdFactory: nativeAdFactory)
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    //app open ad
    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application);
        
         if(isNotFirstTime()){
            print("show ad test");
            self.tryToPresentAd();
        }
    }
    
    func wasLoadTimeLessThanNHoursAgo(n:Double) ->Bool{
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime!)
        let secondsPerHour = 3600.0;
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour;
        return intervalInHours < n;
    }
    
    func requestAppOpenAd(_ showAd:Bool = false){
        self.appOpenAd = nil;
        GADAppOpenAd.load(withAdUnitID: "ca-app-pub-9131188183332364/6021730010", request: GADRequest(), orientation: UIInterfaceOrientation.portrait) { (appOpenAd: GADAppOpenAd?, error: Error?) in
            self.appOpenAd = appOpenAd;
            self.appOpenAd?.fullScreenContentDelegate = self;
            self.loadTime = Date()
            
            if(appOpenAd != nil && showAd && self.isNotFirstTime()){
                let rootController = self.window.rootViewController!
                appOpenAd?.present(fromRootViewController: rootController)
            }
        }
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.requestAppOpenAd()
    }
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("adDidPresentFullScreenContent")
    }
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.requestAppOpenAd()
    }
    
    func tryToPresentAd(){
        let ad:GADAppOpenAd? = self.appOpenAd;
        self.appOpenAd = nil;
        if (ad != nil && wasLoadTimeLessThanNHoursAgo(n: 1) && self.isNotFirstTime()) {
            let rootController = self.window.rootViewController!
            ad?.present(fromRootViewController: rootController)
          } else {
            // If you don't have an ad ready, request one.
            self.requestAppOpenAd(true);
          }
    }
   
    
    
    func isNotFirstTime() -> Bool{
        print(UserDefaults.standard.bool(forKey: "flutter.IS_NOT_FIRST"),"aaaaa");
        return  UserDefaults.standard.bool(forKey: "flutter.IS_NOT_FIRST");
    }
    
    func showPickerView()  {
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        do {
            let bookmarkData = try Data(contentsOf: self.getMyURLForBookmark())
            var isStale = false
            let url = try URL(resolvingBookmarkData: bookmarkData, bookmarkDataIsStale: &isStale)
            guard !isStale else {
                // Handle stale data here
                return
            }
            self.copyFile(url: url)
        }
        catch let error {
            // Handle the error here.
            print(error);
            let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeFolder as String], in: .open)
            documentPicker.delegate = self
            controller.present(documentPicker, animated: true, completion: nil)
        }
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else {
                return
            }
            self.copyFile(url: url)
    }
    func getMyURLForBookmark() -> URL {
        let fileManager = FileManager.default
        let appSupportURL = fileManager.urls (for: .applicationSupportDirectory, in: .userDomainMask).first!.appendingPathComponent ("co.pamobile.mcpe.addonsmaker")
        do {
             // Note: this will fail after the first time, but the failure will be detected when the bookmark file read is tried
             try fileManager.createDirectory(at: appSupportURL, withIntermediateDirectories: true, attributes: nil)
        }
        catch { }
        // Look for an existing bookmark to the Documents folder
        return appSupportURL.appendingPathComponent ("documentsBookmark")
    }
    func copyFile(url:URL){
        print("copyFile");
        let fileManager = FileManager.default
            // Start accessing a security-scoped resource.
        do {
            // Start accessing a security-scoped resource.
            guard url.startAccessingSecurityScopedResource() else {
                // Handle the failure here.
                return
            }
            
            // Make sure you release the security-scoped resource when you are done.
            defer { url.stopAccessingSecurityScopedResource() }
            
            let bookmarkData = try url.bookmarkData(options: .minimalBookmark, includingResourceValuesForKeys: nil, relativeTo: nil)
            
            try bookmarkData.write(to: getMyURLForBookmark())
        }
        catch let error {
            // Handle the error here.
        }
        
        guard url.startAccessingSecurityScopedResource() else {
            // Handle the failure here.
            return
        }
        
        // Make sure you release the security-scoped resource when you are done.
        defer { url.stopAccessingSecurityScopedResource() }
    
        var error: NSError? = nil
        NSFileCoordinator().coordinate(writingItemAt: url, error: &error) { (url) in
            
            let keys : [URLResourceKey] = [.nameKey, .isDirectoryKey]
            
            // Get an enumerator for the directory's content.
            guard let fileList =
                FileManager.default.enumerator(at: url, includingPropertiesForKeys: keys) else {
                    return
            }
            
            for case let file as URL in fileList {
                // Also start accessing the content's security-scoped URL.
                guard url.startAccessingSecurityScopedResource() else {
                    // Handle the failure here.
                    continue
                }
                // Make sure you release the security-scoped resource when you are done.
                defer { url.stopAccessingSecurityScopedResource() }
                if file.absoluteString.hasSuffix("Documents/games/com.mojang/resource_packs/") { // true
                    
                    let dest = file.appendingPathComponent("\(self.resource_path!.lastPathComponent)_\(ShortCodeGenerator.getCode(length: 6))")
                    try? fileManager.copyItem(at: self.resource_path!, to: dest)
                    
                    print(dest)
                }
                
                if file.absoluteString.hasSuffix("Documents/games/com.mojang/behavior_packs/") { // true
                    let dest = file.appendingPathComponent("\(self.behavior_path!.lastPathComponent)_\(ShortCodeGenerator.getCode(length: 6))")
                    try? fileManager.copyItem(at: self.behavior_path!, to: dest)
                    print(dest)
                }
            }
        }
        self.result!(true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

struct ShortCodeGenerator {

    private static let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
    private static let maxBase : UInt32 = 62

    static func getCode(withBase base: UInt32 = maxBase, length: Int) -> String {
        var code = ""
        for _ in 0..<length {
            let random = Int(arc4random_uniform(min(base, maxBase)))
            code.append(base62chars[random])
        }
        return code
    }
}

extension String {

    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }

    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}

