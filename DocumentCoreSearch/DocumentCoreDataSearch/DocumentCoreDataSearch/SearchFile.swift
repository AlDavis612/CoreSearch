//
//  SearchFile.swift
//  DocumentCoreDataSearch
//
//  Created by Alex Davis on 10/4/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import Foundation

enum SearchFile: String {
    case everyone
    case name
    case content
    
    static var titles: [String] {
        get {
            return [SearchFile.everyone.rawValue, SearchFile.name.rawValue, SearchFile.content.rawValue]
        }
    }
    
    static var condition: [SearchFile] {
        get {
            return [SearchFile.everyone, SearchFile.name, SearchFile.content]
        }
    }
}
