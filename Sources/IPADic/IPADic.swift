//
//  IPADic.swift
//
//
//  Created by Morten Bertz on 2021/06/22.
//

import Foundation
import Dictionary

/**
A wrapper around IPADic. A number of dictionaries for mecan can be found on the internet. Different dictionaries privde different features (POS tagging etc), and so far I have not been able to get this information out of mecab at runtime. The dictionary scheme is contained in the dicrc file.
*/
public struct IPADic: DictionaryProviding{

    public let url:URL

    public init(){
        self.url = Bundle.module.url(forResource: "ipadic dictionary", withExtension: nil)!
    }

    public var description: String{
        return "Dictionary: \(url), Type: IPADic"
    }

    public var dictionaryFormIndex: Int {
            return 6
    }

    public var readingIndex:Int{
            return 7
    }

    public var pronunciationIndex:Int{
       return 8
    }

    public func partOfSpeech(posID: UInt16) -> PartOfSpeech {
        // POS-ID groupings derived from IPADic's pos-id.def. Range comments use
        // the canonical IPADic category labels.
        switch posID {
        case 2:                  // 感動詞 (interjection)
            return .interjection
        case 3...9:              // 記号 (symbol)
            return .symbol
        case 10...12:            // 形容詞 (i-adjective) — pre-fix this mapped to .adverb
            return .adjective
        case 13...24:            // 助詞 (particle)
            return .particle
        case 25:                 // 助動詞 (auxiliary verb)
            return .auxiliaryVerb
        case 26:                 // 接続詞 (conjunction)
            return .conjunction
        case 27...30:            // 接頭詞 (prefix)
            return .prefix
        case 31...33:            // 動詞 (verb)
            return .verb
        case 34...35:            // 副詞 (adverb)
            return .adverb
        case 36...67:            // 名詞 (noun)
            return .noun
        case 68:                 // 連体詞 (pre-noun adjective)
            return .preNounAdjective
        default:
            // IDs 0 (その他,間投) and 1 (フィラー) fall here. So do any
            // user-dict-only POS IDs that exceed the IPADic range; downstream
            // surface-form heuristics resolve these.
            return .unknown
        }
    }
}
