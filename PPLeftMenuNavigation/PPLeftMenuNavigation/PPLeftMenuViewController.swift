//
//  PPLeftMenuViewController.swift
//  PPLeftMenuNavigation
//
//  Created by Pierre Perrin on 06/04/2017.
//  Copyright © 2017 PierrePerrin. All rights reserved.
//

import UIKit

class PPLeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var datasource : PPLeftMenuDatasource!
    @IBOutlet var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: TableViewDatasourcing
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1//self.datasource.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.numberOfItem()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PPLeftMenuTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: nil)
        cell.leftMenuItem = self.datasource.itemForRow(row: indexPath.row)
        return cell
    }
    
    var minimumRowHeigth :CGFloat = 55
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var headerHeigth :CGFloat = 0
        
        if let headerView = tableView.tableHeaderView{
            headerHeigth = headerView.frame.size.height
        }
        
        let sectionHeaderAndFooterSize = 2 * (tableView.frame.size.height * headerSizeMultiplier)
        
        let normalHeigth = tableView.frame.size.height - sectionHeaderAndFooterSize - headerHeigth
        let height = normalHeigth / CGFloat(self.datasource.numberOfItem())
        return height < minimumRowHeigth ? minimumRowHeigth : height
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.3) { 
            cell?.alpha = 0.5
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        UIView.animate(withDuration: 0.3) {
            cell?.alpha = 1
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentItem = self.datasource.itemForRow(row: indexPath.row)
        self.datasource.didSelectRow(atIndex: indexPath.row, item: currentItem)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        let defaultSize = tableView.frame.size.height * headerSizeMultiplier
        return self.datasource.menuHeaderView != nil ? self.datasource.menuHeaderView!.frame.size.height : defaultSize
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        let defaultSize = tableView.frame.size.height * headerSizeMultiplier
        return self.datasource.menuFooterView != nil ? self.datasource.menuFooterView!.frame.size.height : defaultSize
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return self.datasource.menuHeaderView == nil ? self.clearView() : self.datasource.menuHeaderView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        return self.datasource.menuFooterView == nil ? self.clearView() : self.datasource.menuFooterView
    }
    
    func clearView() -> UIView{
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    var headerSizeMultiplier :CGFloat {
        
        return UIDevice.current.orientation.isLandscape ? 0 : 0.17
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
