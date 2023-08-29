//
//  MinEdit.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

extension String {

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
}

class Solution {
    var computed : [[Int]] = []
    
    func edit(_ i : Int, _ j: Int, w1: inout String, w2: inout String) -> Int {
        if i == w1.count {
            return (w2.count - j)
        }
        
        if j == w2.count {
            return (w1.count - i)
        }
        
        if w1[i] == w2[j] {
            return edit(i + 1, j + 1, w1: &w1, w2: &w2)
        }
        
        if computed[i][j] != -1 {
            return computed[i][j]
        }
        
        let firstCaseResult = edit(i, j + 1, w1: &w1, w2: &w2)
        let secondCaseResult = edit(i + 1, j, w1: &w1, w2: &w2)
        let thirdCaseResult = edit(i + 1, j + 1, w1: &w1, w2: &w2)
        
        computed[i][j] = 1 + min(min(firstCaseResult, secondCaseResult), thirdCaseResult)
        return computed[i][j]
    }
    
    func minDistance(_ word1: String, _ word2: String) -> Int {
        var copyOfW1 = word1
        var copyOfW2 = word2
        
        // array with dimension (word1.count, word2.count)
        for _ in (0..<word1.count) {
            computed.append(Array(repeating: -1, count: word2.count))
        }
        
        return edit(0, 0, w1: &copyOfW1, w2: &copyOfW2)
    }
}
