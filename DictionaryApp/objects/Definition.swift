//
//  Meaning.swift
//  DictionaryApp
//
//  Created by FVFH4069Q6L7 on 28/08/2023.
//

import Foundation

struct Definition : Identifiable {
    let id = UUID()
    let content: String
    let synonnyms: [String]
    let antonyms: [String]
    let example: String
    
    init() {
        content = "Định danh chỉ những vật người sử dụng và người tiếp nhận đều biết"
        synonnyms = ["a", "An"]
        antonyms = ["adas", "weqwe"]
        
        example = "The boy over there is playing football"
    }
    
    init(entity: DefinitionEntity) {
        content = entity.definition
        example = entity.example ?? ""
        synonnyms = entity.synonyms
        antonyms = entity.antonyms
    }
}
