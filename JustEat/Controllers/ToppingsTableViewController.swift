//
//  ToppingsTableViewController.swift
//  JustEat
//
//  Created by admin on 23/05/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class ToppingsTableViewController: UITableViewController {

    //recibe el producto seleccionado en el cupcakeTableViewController.
    var cupcake: Product!
    //declara un conjunto.
    var selectedToppings = Set<Product>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Añadir decoracion"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pedir ahora", style: .plain, target: self, action: #selector(placeOrder))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ProductsFactory.shared().toppings.count
    }
    
    
    @objc func placeOrder(){
        guard let orderViewController = storyboard?.instantiateViewController(withIdentifier: "OrderVC") as? OrderViewController else{
            fatalError("no se ha podido cargar el view cntroller requerido desde el storyboard")
        }
        //pasamos el cupcake seleccionado y el o los toppings.
        orderViewController.cupcake = cupcake
        orderViewController.toppings = selectedToppings
        
        navigationController?.pushViewController(orderViewController, animated: true)
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToppingCell", for: indexPath)

        let topping = ProductsFactory.shared().toppings[indexPath.row]
        cell.textLabel?.text = "\(topping.name) - \(topping.price)€ "
        cell.detailTextLabel?.text = topping.description

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //comprobamos si la celda existe.
        guard let cell = tableView.cellForRow(at: indexPath) else{
            fatalError("no hemos podido localizar la celda pulsada....")
        }
        
        let topping = ProductsFactory.shared().toppings[indexPath.row]
        
        //si el conjunto selectedtoppings ya contiene el topping pulsado, lo desmarca y lo quita del conjunto.
        //si el conjunto selectedtoppings no tiene el topping pulsado, lo marca y lo añade al conjunto.
        if selectedToppings.contains(topping){
            cell.accessoryType = .none
            selectedToppings.remove(topping)
        }else{
            cell.accessoryType = .checkmark
            selectedToppings.insert(topping)
        }
        
        //no deja el item pulsado en gris.
        tableView.deselectRow(at: indexPath, animated: true)

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
