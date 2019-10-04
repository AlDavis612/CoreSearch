//
//  DocTableViewCell.swift
//  DocumentCoreDataSearch
//
//  Created by Alex Davis on 10/4/19.
//  Copyright © 2019 Alex Davis. All rights reserved.
//

import UIKit

class DocTableViewCell: UITableViewCell {
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var SizeLabel: UILabel!
    @IBOutlet weak var DateModLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
