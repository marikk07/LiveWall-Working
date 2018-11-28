//
//  TermsPrivacy.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 10/20/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import Foundation

enum TermsPrivacyType {
    
    case termsConditions
    case privacyPolicy
    
    var title: String {
        switch self {
        case .privacyPolicy:
            return "Privacy Policy"
        case .termsConditions:
            return "Terms of Service ('Terms')"
        }
    }
    
    var text: NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        let boldAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16, weight: .semibold), NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle : style]
        let plainAttributes = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.paragraphStyle : style]
        switch self {
        case .privacyPolicy:
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            let generalString = NSAttributedString(string: "\nGENERAL\n\n", attributes: boldAttributes)
            let firstString = NSAttributedString(string: "Your privacy is important to us. This privacy policy is intended to give you confidence in the privacy and security of the personal information we obtain from you whether you are using products such as the LUNA Horoscope App or others (the “Products”), uploading information to LUNA and our products’ websites (the “Websites”), such as www.codex.mobi, downloading our applications, or are merely visiting our Websites. However, please note that we are not responsible for any use of your personal information you provide to third-party applications or websites that may be accessed via the Products or Websites. We recommend that you review the privacy policy of any third-party applications or websites that you use.\n\n\n", attributes:plainAttributes)
            let collectionString = NSAttributedString(string: "COLLECTION OF PERSONAL INFORMATION\n\n", attributes: boldAttributes)
            let secondString = NSAttributedString(string: "When you use our Products or Websites, you may be asked for personally identifiable information such as your name, address, date of birth, email address, telephone number.By giving us such information, you will need to consent to our using it in the manner described in this policy.You may withdraw your consent at any time by emailing us at hello@codex.mobi. We will return or destroy your personal information within five days of receipt of your withdrawal of consent. Cookie information, pages you have requested and your IP address may also be recorded by us and/or third parties from your browser as set out in this policy.", attributes:plainAttributes)
            let finalString = NSMutableAttributedString(attributedString: generalString)
            finalString.append(firstString)
            finalString.append(collectionString)
            finalString.append(secondString)
            return finalString as NSAttributedString
        case .termsConditions:
            let lastUpdatedString = NSAttributedString(string: "\nLast updated: (8th of March, 2017)\n\n", attributes: boldAttributes)
            let firstString = NSAttributedString(string: "Please read these Terms of Service ('Terms', 'Terms of Service') carefully before using the website and/or any of our mobile applications (the 'Services') operated by Codex Technologies, IVS. ('us', 'we', or 'our').\n\nYour access to and use of the Services is conditioned on your acceptance of and compliance with these Terms. These Terms apply to all visitors, users and others who access or use the Services.\n\nBy accessing or using the Services you agree to be bound by these Terms. If you disagree with any part of the terms then you may not access the Services.\n\n\n", attributes: plainAttributes)
            let terminationString = NSAttributedString(string: "Termination\n\n", attributes: boldAttributes)
            let secondString = NSAttributedString(string: "We may terminate or suspend access to our Services immediately, without prior notice or liability, for any reason whatsoever, including without limitation if you breach the Terms.", attributes:plainAttributes)
            let finalString = NSMutableAttributedString(attributedString: lastUpdatedString)
            finalString.append(firstString)
            finalString.append(terminationString)
            finalString.append(secondString)
            return finalString as NSAttributedString
        }
    }
}
