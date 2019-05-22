//
//  ArtistViewController.swift
//  Spotify
//
//  Created by Jhonnatan Macias on 7/11/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import UIKit

class ArtistViewController: BaseViewController {
    
    @IBOutlet weak var artistCollectionView : UICollectionView!
    @IBOutlet weak var searchBar            : UISearchBar!
    
    internal var itemSize            : CGSize!
    private var isSearchActived     : Bool  = false
    private var timer               : Timer? = nil
    private var searchText          : String = ""
    internal var artistFilteredArray: Array<Artist> =  Array<Artist>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStylesNavigationBar("Artist")
        self.view.backgroundColor = ColorUtils.hexToUIColor("F0F0F0")
        
        self.setupSearchBar()
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        
        self.artistCollectionView.setCollectionViewLayout(layout, animated: false)
        self.artistCollectionView.alwaysBounceVertical = true
        self.artistCollectionView.backgroundColor = .clear
        self.artistCollectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "ArtistCell")
        self.artistCollectionView.delegate = self
        self.artistCollectionView.dataSource = self
        
        self.itemSize = CGSize(width: (self.view.bounds.width - 30), height: (self.view.bounds.width - 30) / 2)
        
    }
    
    /// set styles and placeholder for SearchBar
    func setupSearchBar() {
        
        self.searchBar.barTintColor = ColorUtils.hexToUIColor("00AC43")
        self.searchBar.delegate = self
        self.searchBar.returnKeyType = .done
        
        // change title and styles of cancel button
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel"
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white], for: .normal)
        
        let placeholderAttributes: [NSAttributedStringKey : AnyObject] = [NSAttributedStringKey.foregroundColor: UIColor.gray, NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 14)]
        let attributedPlaceholder: NSAttributedString = NSAttributedString(string: "Search your favorite Artist", attributes: placeholderAttributes)
        let textFieldPlaceHolder = searchBar.value(forKey: "searchField") as? UITextField
        textFieldPlaceHolder?.attributedPlaceholder = attributedPlaceholder
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func presentAlbumView() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let albumView = storyboard.instantiateViewController(withIdentifier: "albumes") as! AlbumsTableViewController
        albumView.artistName = self.searchText
        self.navigationController?.pushViewController(albumView, animated: true)
        
    }
}


extension ArtistViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar .resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.dismissKeyboard()
    }
    
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            self.addSpinner()
            self.isSearchActived = true
            self.searchArtist(searchText)
        } else {
            self.artistFilteredArray.removeAll()
            self.artistCollectionView.reloadData()
            self.isSearchActived = false
            self.dismissKeyboard()
        }
        
    }
    
    
    /// search a product
    ///
    /// - Parameter searchText: the name of product for looking
    func searchArtist(_ searchText: String) {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.dismissKeyboard), userInfo: searchBar, repeats: false)
        //
        self.searchText = searchText.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if searchText.isEmpty {
            
        } else {
            let artistName = searchText.replacingOccurrences(of: " ", with: "%20")
            ArtistController.getArtist(artistName: artistName) { (artists, error, errorMessage, status) in
                if !error {
                    self.artistFilteredArray = artists
                    self.artistCollectionView.reloadData()
                } else {
                    self.showAlert(errorMessage)
                }
            }
        }
        
        
        
        //        self.artistFilteredArray = Array(self.productsArray.filter({$0.name.lowercased().contains(searchText.lowercased())}))
        //        self.collectionViewProducts.reloadData()
        self.removeSpinner()
        
    }
}
