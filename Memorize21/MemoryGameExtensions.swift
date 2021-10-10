import SwiftUI

// https://www.hackingwithswift.com/example-code/system/how-to-read-your-apps-version-from-your-infoplist-file
extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
