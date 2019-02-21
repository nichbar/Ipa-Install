//
//  ViewController.swift
//  Ipa-Install
//
//  Created by nich on 2019/2/21.
//  Copyright © 2019 nich. All rights reserved.
//

import UIKit
import Tiercel

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadIpa()
    }
    
    func downloadIpa() {
        // Replace this ipa url with yours.
        let downloadUrl = "https://raw.githubusercontent.com/geekonion/ipaTest/master/SecMail.ipa"
        
        // Create a download task.
        let task = TRManager.default.download(downloadUrl, fileName: "x.ipa")
        
        // Start a http server right after the downloading the ipa and install it via plist.
        task?.progress({ (task) in
            let progress = task.progress.fractionCompleted
            print("Downloading, progress -> ：\(progress)")
        }).success({ (task) in
            print("Download complete.")
            let plist = "https://raw.githubusercontent.com/nichbar/Ipa-Install/master/property.plist"
            
            AppDelegate.startServer()
            
            let url = URL(string: "itms-services://?action=download-manifest&url=" + plist)
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url!)
            }
            
        }).failure({ (task) in
            print("Download failed.")
        })
    }
}

