//
//  File.swift
//  Mecab-Swift
//
//  Created by Morten Bertz on 2025/05/15.
//

import Testing
import Foundation
import Dictionary
import Mecab_Swift

struct UniDic:DictionaryProviding{
    let url: URL = URL.init(string: ".")!
    //the url has to be accessible from the xcode sandbox - one easy way to do this is to grant full disk access to xcode
    
    var readingIndex: Int = 9
    
    var pronunciationIndex: Int = 0
    
    var dictionaryFormIndex: Int = 6
    
    func partOfSpeech(posID: UInt16) -> PartOfSpeech {
        return .unknown
    }
    
}


@Test func testUnidic() async throws {
    
    let unidic = UniDic()
    
    await #expect(throws: Tokenizer.TokenizerError.self, performing: {
        let tokenizer = try await Tokenizer(dictionary: unidic)
        
        let string = "2025年3月16日"
        
        let tokens = await tokenizer.tokenize(text: string)
        for token in tokens{
            print("token: \(token.base), reading: \(token.reading)")
        }
        #expect(tokens.isEmpty == false)
    })
    
    
    
    
}
