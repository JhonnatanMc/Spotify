//
//  ArtistViewControllerCollectionView.swift
//  Spotify
//
//  Created by Jhonnatan Macias on 7/14/18.
//  Copyright © 2018 Jhonnatan Macias. All rights reserved.
//

import Foundation

extension ArtistViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.artistFilteredArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        self.presentAlbumView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as! ArtistCollectionViewCell
        
        let item = artistFilteredArray[indexPath.item]
        cell.setArtist(item)
        cell.backgroundColor = .clear
        cell.tag = indexPath.item
        
        if item.imageURL.first?.imagePath != nil  && !(item.imageURL.first?.imagePath.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty)! {
            cell.showLoadingSpinner()
            ImageUtils.getOriginalImage((self.artistFilteredArray[indexPath.item].imageURL.first?.imagePath)!) { (image) in
                cell.hideLoadingSpinner()
                cell.setImage(image)
            }
        } else {
            cell.setImage(UIImage(named: "default_cover")!)
        }
        return cell
    }
}
