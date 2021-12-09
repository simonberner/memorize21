import SwiftUI

// Read values from Info.plist
// https://sarunw.com/posts/how-to-read-info-plist/
// https://www.hackingwithswift.com/example-code/system/how-to-read-your-apps-version-from-your-infoplist-file
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    static var buildVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
}
