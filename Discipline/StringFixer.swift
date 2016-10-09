//
//  StringFixer.swift
//  HabitMinder
//
//  Created by Shannon Layden on 9/11/16.
//  Copyright © 2016 Shannon. All rights reserved.
//

import Foundation

class StringFixer{
    
    
   static func SentenceCase(_ text:String) -> String
    {
        return text.capitalized
    }
    
  static  func MakeOperatorPlural(_ text:String) -> String
    {
        return text.replacingOccurrences(of: "@", with: "s")

    }
    
  static  func MakeOperatorSingle(_ text:String) -> String {
        
        return text.replacingOccurrences(of: "@", with: "")
    }
    
    static func fixNumber(_ number:Double)->String
    {
      return String(format: number == floor(number) ? "%.0f" : "%.1f", number)
    }
    
}
