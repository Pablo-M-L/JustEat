//
//  OrderViewController.swift
//  JustEat
//
//  Created by admin on 23/05/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Intents

class OrderViewController: UIViewController {
    
    var cupcake : Product!
    var toppings = Set<Product>()

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var orderLabel: UILabel!
    
    @IBOutlet weak var costLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "pedido completado"
        //oculta el boton back.
        navigationItem.hidesBackButton = true
        //añadir button item a la derecha para acabar el pedido.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))

        //Corregir error xcode que no aplica la propiedad tintColor una imagen vectorial.
        let image = imageView.image
        imageView.image = nil
        imageView.image = image?.withRenderingMode(.alwaysTemplate)
        
        let order = Order(cupcake: cupcake, toppings: toppings)
        //mostrar en pantalla
        showOrderDetails(order)
        //pasar al servidor/restaurante
        sendToServer(order)
        //pasar a siri
        donate(order)
        
    }
    
    //muesta el pedido
    func showOrderDetails( _ order: Order){
        orderLabel.text = order.name
        costLabel.text = "\(order.priceOrder) €"
    }
    
    //simulacion de envio del order al server.
    func sendToServer(_ order : Order){
        //creamos un json
        let encoder = JSONEncoder()
        
        do{
            //creo datos a partir del objeto Order.
            let data = try encoder.encode(order)
            print(data)
            //TODO enviar data al server para su procesado en la tienda.
        }
        catch{
            print("error al enviar el pedido al restaurante")
        }
    }
    
    //crea la actividad para siri.
    func donate (_ order: Order){
        
        
    }

    @objc func done(){
        //volver a la pantalla incial.
        navigationController?.popToRootViewController(animated: true)
    }

}
