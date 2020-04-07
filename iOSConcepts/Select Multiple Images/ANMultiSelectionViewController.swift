//
//  ANMultiSelectionViewController.swift
//  iOSConcepts
//
//  Created by IMAC-0025 on 05/04/20.
//  Copyright © 2020 Avijit Nagare. All rights reserved.
//

import UIKit
import PhotosUI

protocol ANMultiSelectionViewControllerDelegate {
    func passImagesBackToController(array:[UIImage])
}

class ANMultiSelectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var multiSelectionCollectionView: UICollectionView!
    var currentImageAddedCount = 0;
    
    var imageAssets = [PHAsset]()
    var selectedImageArray = [String]()
    
    var cellIdentifire = "selectImageCell"
    
    var imageDelegate: ANMultiSelectionViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.multiSelectionCollectionView.dataSource = self;
        self.multiSelectionCollectionView.delegate = self;
        getAllImagesFromGallary()
        // Do any additional setup after loading the view.
    }
    func getAllImagesFromGallary() {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.denied  || PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.restricted {
            //Access Denited
        }else{
            PHPhotoLibrary.requestAuthorization { (status) in
                let fetchOptions = PHFetchOptions()
                fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
                let imgArr = PHAsset.fetchAssets(with: .image, options: fetchOptions) as PHFetchResult
                for i in 0 ..< imgArr.count {
                    self.imageAssets.append(imgArr[i])
                    print(self.imageAssets[i])
                }
                
            }
            DispatchQueue.main.async {
                self.multiSelectionCollectionView.reloadData()
            }
            
        }
    }
    
    func getAssetThumbnail(asset: PHAsset) -> UIImage? {
        
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        var temp: UIImage?
        PHImageManager.default().requestImageData(for: asset, options: option) {  (imageData, dataUII, orientation, info) in
            if let data = imageData {
                temp = UIImage(data: data)!
            }
        }
        return temp
    }
    @IBAction func backButtonClicked(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        if selectedImageArray.count == 0 {
            //No image selected
        }else{
            var images = [UIImage]()
            for index in selectedImageArray {
                let pos = Int(index)
                images.append(self.getAssetThumbnail(asset:imageAssets[pos!])!)
            }
            self.imageDelegate?.passImagesBackToController(array: images)
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageAssets.count
    }
         
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifire, for: indexPath) as! ImageSelectionCell
        
        cell.galleryImageView.image = self.getAssetThumbnail(asset: imageAssets[indexPath.row])
        
        if selectedImageArray.contains(String("\(indexPath.row)")) {
            cell.chekUnCheckImageView.image = UIImage(named:"checked")
        }else{
            cell.chekUnCheckImageView.image = UIImage(named:"unchecked")
        }

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         
        if (selectedImageArray.contains(String("\(indexPath.row)"))) {
            //selectedImageArray removeObjectAtIndex:[selectedImageArray indexOfObject:selectedRow]];
            selectedImageArray.remove(at: selectedImageArray.firstIndex(of:String("\(indexPath.row)"))!)
        }else{
            selectedImageArray.append(String("\(indexPath.row)"))
        }
            
    }
   
   
       
    
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ANMultiSelectionViewController : UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
