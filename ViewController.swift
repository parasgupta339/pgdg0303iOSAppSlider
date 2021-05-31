//
//  ViewController.swift
//  Slider
//
//  Created by paras gupta on 29/05/21.
//

import UIKit
import SideMenu

class ViewController: UIViewController, MenuControllerDelegate  {
   
    
    private var sideMenu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuController(with: ["first","second","third","four"])
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        menu.delegate = self
        sideMenu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
     }

    @IBAction func didTappedButton(){
       present(sideMenu!, animated: true)
    }
    func didSelectMenu(named: String) {
        sideMenu?.dismiss(animated: true, completion: { [weak self] in
            if named == "first"{
                self?.view.backgroundColor = .red
            }else if named == "second"{
                self?.view.backgroundColor = .green
            }else if named == "third"{
                self?.view.backgroundColor = .blue
            }else if named == "four" {
                self?.view.backgroundColor = .yellow
            }
        })
    }
    
}

protocol MenuControllerDelegate {
    func didSelectMenu(named: String)
}

class MenuController: UITableViewController{
    
    public var delegate: MenuControllerDelegate?
    
    private let menuItems: [String]
    private let color = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
    
    init(with menuItems: [String]){
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = color
        
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = color
        cell.contentView.backgroundColor = color
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenu(named: selectedItem)
    }
}

