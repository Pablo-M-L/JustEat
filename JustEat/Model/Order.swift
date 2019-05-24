//
//  Order.swift
//  JustEat
//
//  Created by admin on 24/05/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

struct Order: Codable, Hashable{
    var cupcake : Product
    var toppings : Set<Product>
    
    var name : String{
        if toppings.count == 0{
            return cupcake.name
        }
        else{
            /*
            //version extendida.
            let toppingNames = toppings.map { (p) -> T in
                return p.name.lowercased()
            }
             */
            //version reducida.
            //de cada topping coje el nombe, lo pone en minusculas
            let toppingNames = toppings.map{
                $0.name.lowercased()
            }
            
            //muestra los toppingsNames generados en minusculas separados por una coma.
            return "\(cupcake.name) con \(toppingNames.joined(separator: ", "))."
        }
    }
    
    var priceOrder : Int{

        //suma el precio del cupcake mas el precion de lo topping usando un reduce.
        //resultado inicial es el valor del pastel.
        //resultado anterior ($0) mas el resultado actual ($1.price).
        return toppings.reduce(cupcake.price){ $0 + $1.price}
    }
    

}
