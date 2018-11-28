//
//  UITextView+.swift
//  coloringbook
//
//  Created by Iulian Dima on 4/16/17.
//  Copyright © 2017 Tapptil. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func setAttributedStringFromHTML(_ htmlCode: String, completion: @escaping (NSAttributedString?) ->()) {
         let inputText = NSString(format:"<span style=\"font-family: '\(self.font!.fontName)'; font-size: \(self.font!.pointSize)\">\(htmlCode)</span>" as NSString) as String
        

        guard let data = inputText.data(using: String.Encoding.utf16) else {
            print("Unable to decode data from html string: \(self)")
            return completion(nil)
        }
        
        /*DispatchQueue.main.async {
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                self.attributedText = attributedString
                completion(attributedString)
            } else {
                print("Unable to create attributed string from html string: \(self)")
                completion(nil)
            }
        } */
    }
}
