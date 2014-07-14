//
//  Item.swift
//  SwiftTestingSample
//
//  Created by haranicle on 2014/07/11.
//  Copyright (c) 2014年 haranicle. All rights reserved.
//

import Foundation

class Item : NSObject {
    
    var id:String = ""
    var title:String
    var price:Int
    var type:String
    
    init(title:String, price:Int, type:String){
        self.title = title
        self.price = price
        self.type = type
        // self.id = generateId()
    }
    
    func generateId() -> String {
        return "id-\(type)-\(title)"
    }
    
    func totalPrice(count:Int) -> Int {
        return price * count
    }
    
    
    override func isEqual(other: AnyObject!) -> Bool {
        
        if(other.id == id && other.title == title && other.price == price && other.type == type) {
            return true
        }
        
        return false
    }
    
}