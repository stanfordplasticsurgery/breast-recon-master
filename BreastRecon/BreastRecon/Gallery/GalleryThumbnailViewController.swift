//
//  GalleryThumbnailViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/29/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryThumbnailViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    // MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imagesArray:[[UIImage]] = []
    var container:GalleryContainerViewController?
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imagesArray = readThumbnailsConfig()
        self.automaticallyAdjustsScrollViewInsets = false;
        self.view.addSubview(collectionView)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = UIColor.whiteColor()
    }

    func readThumbnailsConfig() -> [[UIImage]] {

        var array:[[UIImage]] = []

        var dict:NSMutableDictionary = NSMutableDictionary()
        if let path = NSBundle.mainBundle().pathForResource("ThumbnailsConfig", ofType: "plist") {
            dict = NSMutableDictionary(contentsOfFile: path)!
        }

        for index in 0...dict.count - 1 {
            var element:[UIImage] = []
            var indexString:String = "\(index)"
            var value:[String] = dict.objectForKey(indexString) as [String]
            element.append(UIImage(named: "thumbnails/\(value[0])")!)
            element.append(UIImage(named: "fullsize/\(value[1])")!)
            array.append(element)
        }
        return array
    }

    // MARK: - Other View Controller Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillLayoutSubviews() {
        let itemSize:CGSize = CGSize(width: 150, height: 150)
        let layout: GalleryThumbnailCollectionLayout = GalleryThumbnailCollectionLayout()
        layout.itemSize = itemSize
        collectionView.collectionViewLayout = layout
    }
    
    // MARK: - Collection view data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagesArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as ThumbnailCollectionViewCell
        var images:[UIImage] = imagesArray[indexPath.row] as [UIImage]
        var image:UIImage = images[0]
        cell.imageView?.image = image
        cell.backgroundColor = UIColor.blueColor()
        return cell
    }

    // MARK: - Collection view delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.container?.updateBigPicture(self.imagesArray[indexPath.row][1])
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
