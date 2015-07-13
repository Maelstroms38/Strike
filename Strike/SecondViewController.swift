//
//  SecondViewController.swift
//  Strike
//
//  Created by Michael Stromer on 9/16/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

import UIKit

var toDoItems:[String] = []

class SecondViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {
    
    @IBOutlet var tasksTable:UITableView!
    
    @IBOutlet var toDoItem : UITextField!
    
    
    @IBAction func addItem(sender : AnyObject) {
        
        toDoItems.append(toDoItem.text)
        
        let fixedtoDoItems = toDoItems
        NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        self.view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        return toDoItems.count
        
    }
    
    
    
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = toDoItems[indexPath.row]
        
        return cell
        
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if var storedtoDoItems : AnyObject = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") {
            
            toDoItems = []
            
            for var i = 0; i < storedtoDoItems.count; ++i {
                
                toDoItems.append(storedtoDoItems[i] as NSString)
                
            }
            
            
        }
        
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            
            toDoItems.removeAtIndex(indexPath.row)
            
            let fixedtoDoItems = toDoItems
            NSUserDefaults.standardUserDefaults().setObject(fixedtoDoItems, forKey: "toDoItems")
            NSUserDefaults.standardUserDefaults().synchronize()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
        
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    
    
    
    
}
