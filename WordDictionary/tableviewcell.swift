//
//  tableviewcell.swift
//  WordDictionary
//
//  Created by kopyoloid on 17/02/21.
//

import UIKit

class cello : UITableViewCell{
 
    @IBOutlet weak var word: UILabel!
   
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
