//
//  StringFixer.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/11/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation

class StringFixer{
    
    
   static func SentenceCase(text:String) -> String
    {
        return text.capitalizedString
    }
    
  static  func MakeOperatorPlural(text:String) -> String
    {
        return text.stringByReplacingOccurrencesOfString("@", withString: "s")

    }
    
  static  func MakeOperatorSingle(text:String) -> String {
        
        return text.stringByReplacingOccurrencesOfString("@", withString: "")
    }
    
}