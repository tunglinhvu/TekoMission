//
//  NSUserDefaultsManager.swift
//  TekoMission
//
//  Created by linhvt on 6/29/19.
//  Copyright © 2019 ntq. All rights reserved.
//

import Foundation

struct KeyUserDefaults {

}

class NSUserDefaultsManager {
    /**
     *  clear value for key in UserDefaults
     *
     *  @params
     - key: key
     *  @return void
     */
    public static func clearValueInUserDefaults(_ key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }

    /**
     *  save string in UserDefaults
     *
     *  @params
     - value: value
     - key: key
     *  @return void
     */
    public static func saveStringInUserDefaults(_ value: String, _ key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }

    /**
     get string in UserDefaults

     - returns:
     string

     - Parameters:
     + key: key saved

     */
    public static func getStringInUserDefaults(_ key: String) -> String {
        let defaults = UserDefaults.standard
        if let string = defaults.string(forKey: key) {
            return string
        } else {
            return ""
        }
    }

    public static func saveBooleanInUserDefaults(_ value: Bool, _ key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: key)
    }

    public static func getBooleanInUserDefaults(_ key: String) -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: key)
    }
}
