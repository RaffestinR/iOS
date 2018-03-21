//
//  Tuple.swift
//  BBResto
//
//  Created by tp on 20/03/2018.
//  Copyright © 2018 Vavavax Company. All rights reserved.
//

import Foundation

class Tuple{
    var name:String = ""
    var lati:Double = 0.0
    var long: Double = 0.0
    
    init(_ name:String,_ lati:Double,_ long:Double){
        self.name=name
        self.lati=lati
        self.long=long
    }
}
