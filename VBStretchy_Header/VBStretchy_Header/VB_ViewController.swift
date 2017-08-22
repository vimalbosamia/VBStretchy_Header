//
//  VB_ViewController.swift
//  VBStretchy_Header
//
//  Created by Vimal on 8/22/17.
//  Copyright © 2017 Crypton. All rights reserved.
//

let offset_Header:CGFloat = 166  // At this offset the Header stops its transformations
let distance:CGFloat = 30.0

import UIKit

class VB_ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate , UIScrollViewDelegate {
    @IBOutlet var VBHeaderView: UIView!
    @IBOutlet var VBMytableView: UITableView!
  var darkBlur:UIBlurEffect = UIBlurEffect()
    override func viewDidLoad() {
        super.viewDidLoad()


        self.VBMytableView?.contentInset = UIEdgeInsetsMake(VBHeaderView.frame.height, 0, 0, 0)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.VBMytableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as UITableViewCell
         cell.textLabel?.text = "\(indexPath.row + 1)."
        return cell
    }

    //
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offset = scrollView.contentOffset.y + VBHeaderView.bounds.height
        var avatarTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / VBHeaderView.bounds.height
            let headerSizevariation = ((VBHeaderView.bounds.height * (1.0 + headerScaleFactor)) - VBHeaderView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            // Hide views if scrolled super fast
            VBHeaderView.layer.zPosition = 0
            VBHeaderView.isHidden = false
        }
            // SCROLL UP/DOWN ------------
        else {
            // Header -----------
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-offset_Header, -offset), 0)

        }
        // Apply Transformations
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < 0
        {
            VBHeaderView.isHidden = false
        }
        VBHeaderView.layer.transform = headerTransform
    }
}
