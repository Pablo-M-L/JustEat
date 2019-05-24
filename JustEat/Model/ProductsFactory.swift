//
//  ProductsFActory.swift
//  JustEat
//
//  Created by admin on 23/05/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation

class ProductsFactory {
    var cupcakes = [Product]()
    var toppings = [Product]()
    
    //singleton
    private static var sharedFactory : ProductsFactory = {
        let factory = ProductsFactory()
        //configuracion adicional
        return factory
    }()
    
    private init() {
        cupcakes = loadProduct(name: "cupcakes")
        toppings = loadProduct(name: "toppings")
        
    }
    
    private func loadProduct(name: String) ->[Product]{
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else{
            fatalError("no se ha encontrado el fichero \(name).json en la aplicacion")
        }
        
        var tempProduct = [Product]()
        if let data = try? Data(contentsOf: url){
            let decoder = JSONDecoder()
            //?? asigna el valor en caso de que no encuentre el valores en data.
            tempProduct = (try? decoder.decode([Product].self, from: data)) ?? [Product]()
            tempProduct.sort {
                return $0.name < $1.name
            }
        }
        
        return tempProduct
    }
    
    class func shared() -> ProductsFactory{
        return sharedFactory
    }
    
    
}
