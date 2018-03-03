//
//  ContactsViewController.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

let gm = GameManager()

class ContactsViewController: UITableViewController {
    
    var loadedCharacters = [Sender]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadedCharacters = gm.senders
        
        print(loadedCharacters)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedCharacters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
                fatalError("Dequeued cell not of type: ContactCell")
            }
            
            let contact = loadedCharacters[indexPath.row]
            
            cell.sender = contact
            cell.name.text = contact.name
            //icon - from dating app?
            
            return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contactCell = self.tableView(tableView, cellForRowAt: indexPath) as? ContactCell else {
            fatalError("Dequeued cell not of type: ContactCell")
        }
        
        if(contactCell.sender != nil) {
            let messagingScene = self.storyboard!.instantiateViewController(withIdentifier: "Messaging") as! GameViewController;
            
            messagingScene.sender = contactCell.sender!;
            
            self.present(messagingScene, animated: true, completion: nil)
        }
    }

}

class ContactCell : UITableViewCell {
    
    @IBOutlet weak var name: UITextField!
    
    var sender : Sender?
    //let icon
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
