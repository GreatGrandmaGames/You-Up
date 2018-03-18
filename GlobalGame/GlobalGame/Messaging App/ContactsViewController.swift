//
//  ContactsViewController.swift
//  GlobalGame
//
//  Created by Elliot Richard John Winch on 2/17/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

let gm = GameManager()

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var contactsList: UITableView!
    
    var loadedCharacters = [Sender]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        contactsList.delegate = self
        contactsList.dataSource = self
                
        loadedCharacters = gm.senders
        
        print(loadedCharacters)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loadedCharacters.count
    }
    
    //9a added
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell {
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as? ContactCell else {
                fatalError("Dequeued cell not of type: ContactCell")
            }
            
            let contact = loadedCharacters[indexPath.row]
            
            //SET VISUAL PROPERTIES TO DISPLAY IN CELL
            cell.sender = contact
            cell.nameField.text = contact.name
            cell.nameField.font = UIFont(name: "Avenir", size: 24)
            cell.contactImage.image = UIImage(named: (contact.name))
            //i dont know if there is a different way we might want to control this in the future
            if(contact.newMessage){
                cell.newMessage.image = UIImage(named: ("newMessageCircle"))
            }
            if(contact.knownFrom == .Wink){
                cell.winkLogo.image = UIImage(named: ("winkLogo2"))
            }
            //cell.profilePic
            
            return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let contactCell = self.tableView(tableView, cellForRowAt: indexPath) as? ContactCell else {
            fatalError("Dequeued cell not of type: ContactCell")
        }
        
        if(contactCell.sender != nil) {
            let messagingScene = self.storyboard!.instantiateViewController(withIdentifier: "Messaging") as! GameViewController;
            
    
            
            messagingScene.sender = contactCell.sender!
            self.present(messagingScene, animated: false, completion: nil)
            
        }
    }
    
    
}



class ContactCell : UITableViewCell {
    
    
    @IBOutlet weak var newMessage: UIImageView! //red bubble indicating you have a new message from this person
    @IBOutlet weak var nameField: UILabel! //the displayed name
    @IBOutlet weak var contactImage: UIImageView! //the profile image
    @IBOutlet weak var winkLogo: UIImageView! //the logo to display the wink sign, indicating that the person was met on Wink
    
    var sender : Sender?
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
