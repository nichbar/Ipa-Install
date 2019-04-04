//
//  SwifterFile.swift
//  Ipa-Install
//
//  Created by nich on 2019/4/4.
//  Copyright © 2019 nich. All rights reserved.
//

import Foundation
import Swifter

public func shareFilesFromDirectoryWithContentLength(_ directoryPath: String, defaults: [String] = ["index.html", "default.html"]) -> ((HttpRequest) -> HttpResponse) {
    return { r in
        guard let fileRelativePath = r.params.first else {
            return .notFound
        }
        if fileRelativePath.value.isEmpty {
            for path in defaults {
                if let file = try? (directoryPath + String.pathSeparator + path).openForReading() {
                    return .raw(200, "OK", [:], { writer in
                        try? writer.write(file)
                        file.close()
                    })
                }
            }
        }
        if let file = try? (directoryPath + String.pathSeparator + fileRelativePath.value).openForReading() {
            let mimeType = fileRelativePath.value.mimeType();
            
            let filePath = directoryPath + String.pathSeparator + fileRelativePath.value
            var fileSize : UInt64 = 0
            
            do {
                let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                fileSize = attr[FileAttributeKey.size] as! UInt64
                
                let dict = attr as NSDictionary
                fileSize = dict.fileSize()
            } catch {
                print("Error: \(error)")
            }
            
            return .raw(200, "OK", ["Content-Type": mimeType, "Content-Length": String(fileSize)], { writer in
                try? writer.write(file)
                file.close()
            })
        }
        return .notFound
    }
}
