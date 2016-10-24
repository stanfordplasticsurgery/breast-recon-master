//
//  GalleryViewController2.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/30/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class GalleryContainerViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate, UIWebViewDelegate  {

    // MARK: - Variables
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var bigDocument: UIWebView!
    @IBOutlet weak var bigPicture: UIImageView!
    @IBOutlet weak var thumbnailCollection: UICollectionView!
    @IBOutlet weak var bigPictureLabel: UILabel!
    @IBOutlet weak var bigPictureBackground: UIView!
    @IBOutlet weak var showTextOverlayButton: UIButton!
    @IBOutlet weak var bigDocumentView: UIView!

    var currentGallery: MenuItemGallery?
    var currentImageIndex: Int!
    var galleryTextOverlayView: GalleryTextOverlay!
    var galleryImageTitleView: UIView!
    var bigDocumentScrollViewSize: CGSize!
    var splitVC: UISplitViewController?

    let fontSize:CGFloat = 25.0
    let textOverlaySize: CGSize = CGSize(width: 824, height: 100.0)
    let ImageTitleFontSize: CGFloat = 28.0

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    override func viewWillDisappear(animated: Bool) {
        if let overlay = self.galleryTextOverlayView? {
            overlay.hidden = true
        }
    }

    func setup() {
        self.currentImageIndex = 0
        self.currentGallery = MenuItemGallery()

        self.setupThumbnailCollectionView()
        self.setupBigDocument()
        self.setupBigPicture()
        self.setupTextOverlay()

        self.setupBigViewGesture("bigViewTapped")
        self.setupThumbnailGesture("thumbnailDoubleTapped:")

        self.splitVC = self.splitViewController
    }

    private func setupThumbnailCollectionView() {
        self.thumbnailCollection.dataSource = self
        self.thumbnailCollection.delegate = self
        self.thumbnailCollection.backgroundColor = AppConfig.sharedInstance.thumbnail_background()
        self.thumbnailCollection.collectionViewLayout = self.thumbnailViewLayout()
        self.thumbnailCollection.registerClass(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }

    private func setupBigDocument() {
        self.bigDocumentScrollViewSize = CGSize(width: 1, height: self.bigDocument.scrollView.contentSize.height)
        self.bigDocument.scrollView.showsHorizontalScrollIndicator = false
        self.bigDocument.delegate = self
    }

    private func setupBigPicture() {
        self.bigPictureLabel.textColor  = AppConfig.sharedInstance.image_title_text()
        self.bigPictureLabel.font       = AppConfig.sharedInstance.font_default_regular(fontSize)

        self.bigPictureBackground.backgroundColor = AppConfig.sharedInstance.imageBorder_background();
        
        self.showTextOverlayButton.tintColor = AppConfig.sharedInstance.image_button()
    }

    private func setupTextOverlay() {
        let frame = CGRect(x: 100, y: 384, width: textOverlaySize.width, height: textOverlaySize.height)
        self.galleryTextOverlayView = GalleryTextOverlay(frame: frame)
    }

    private func setupBigViewGesture(functionName:Selector){
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: functionName)
        tapGesture.delegate = self
        bigView.addGestureRecognizer(tapGesture)
        bigView.userInteractionEnabled = true
    }

    private func setupThumbnailGesture(functionName:Selector){
        let doubleTapGesture = UITapGestureRecognizer()
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.addTarget(self, action: functionName)
        thumbnailCollection.addGestureRecognizer(doubleTapGesture)
        thumbnailCollection.userInteractionEnabled = true
    }

    private func goToFullScreen(gallery:MenuItemGallery, index: Int){
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let fullScreenView = self.storyboard?.instantiateViewControllerWithIdentifier("GalleryFullSizeView") as GalleryFullScreenViewController
        let navVC = appDelegate.gallerySplitViewController!.viewControllers[0] as GalleryNavController
        let masterVC = navVC.viewControllers[0] as GalleryMasterViewController
        fullScreenView.currentImageIndex = self.currentImageIndex
        fullScreenView.gallery = self.currentGallery
        appDelegate.window?.rootViewController = fullScreenView
    }

    private func thumbnailViewLayout() -> GalleryThumbnailCollectionLayout {
        let itemSize:CGSize = CGSize(width: 170, height: 170)
        let lineSpacing:CGFloat = 50
        let layout: GalleryThumbnailCollectionLayout = GalleryThumbnailCollectionLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        layout.itemSize = itemSize
        layout.minimumLineSpacing = lineSpacing
        return layout
    }

    func getImageTitle() -> String{
        if let images = self.currentGallery!.images {
            if let image = images[currentImageIndex] as GalleryImage? {
                if let detail = image.title {
                    if(countElements(detail) > 0){
                        return detail
                    }
                }
            }
        }
        return ""
    }

    func getTextOverlay() -> String {
        if let images = self.currentGallery!.images {
            if let image = images[currentImageIndex] as GalleryImage? {
                if let detail = image.details {
                    if(countElements(detail) > 0){
                        return detail
                    }
                }
            }
        }

        if let detail = self.currentGallery!.details{
            if(countElements(detail) > 0){
                return detail
            }
        }
        return ""
    }

    func parsePlistText(title:String) -> String {
        var nsTitle:NSString = title as NSString

        let replaceNewLineString:String = "\\n"
        let withNewLineString:String = "\n"

        let replaceTabString:String = "\\t"
        let withTabString:String = "\t"

        nsTitle = nsTitle.stringByReplacingOccurrencesOfString(replaceTabString, withString: withTabString) as String
        nsTitle = nsTitle.stringByReplacingOccurrencesOfString(replaceNewLineString, withString: withNewLineString) as String

        return nsTitle
    }

    // MARK: - Other View Controller Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateBigPicture(image:UIImage) {
        self.bigPicture.image = image

        self.bigDocumentView.hidden = true
        self.bigDocumentView.frame = CGRectZero

        self.bigPictureLabel.text = self.getImageTitle()

        let overlayText:String = self.parsePlistText(self.getTextOverlay())
        self.galleryTextOverlayView.label.text = overlayText

        if (overlayText == "") {
            self.showTextOverlayButton.hidden = true
            return
        }
        self.showTextOverlayButton.hidden = false
    }

    func showTextOverlay() {
        let finalLabelFrame = self.getTextOverlayLabelFrame()
        let finalViewFrame = self.getTextOverlayViewFrame(finalLabelFrame)

        self.galleryTextOverlayView.label.frame = CGRect(
            origin: CGPoint(
                x: finalLabelFrame.origin.x,
                y: finalLabelFrame.origin.y
            ),
            size: CGSize(
                width: finalLabelFrame.size.width,
                height: finalLabelFrame.size.height
            )
        )

        let startFrame = CGRect(
            origin: CGPoint(
                x: finalViewFrame.origin.x + finalViewFrame.size.width,
                y: self.showTextOverlayButton.center.y
            ),
            size: CGSize(
                width: 0,
                height: 2
            )
        )

        let checkpointFrame = CGRect(
            origin: CGPoint(
                x: finalViewFrame.origin.x,
                y: self.showTextOverlayButton.center.y
            ),
            size: CGSize(
                width: finalViewFrame.width,
                height: 2
            )
        )

        self.galleryTextOverlayView.frame = startFrame

        self.galleryTextOverlayView.label.alpha = 0

        let animationDuration:NSTimeInterval = 0.3

        UIView.animateWithDuration(
            0.1,
            animations: {
                self.galleryTextOverlayView.frame = checkpointFrame
            },
            completion: {
                (value:Bool) in
                    UIView.animateWithDuration(
                        animationDuration,
                        animations: {
                            self.galleryTextOverlayView.frame = finalViewFrame
                        },
                        completion: {
                            (value:Bool) in
                                UIView.animateWithDuration(
                                    animationDuration,
                                    animations: {
                                        self.galleryTextOverlayView.label.alpha = 1.0
                                    }
                                )
                        }
                )
            }
        )
    }

    func getTextOverlayLabelFrame() -> CGRect {
        let padding:CGFloat = 10.0
        let width = (self.textOverlaySize.width - (padding * 2))
        let label = UILabel(frame: CGRect(x: padding, y: padding, width: width, height: CGFloat.max))
        label.font = self.galleryTextOverlayView.label.font
        label.text = self.galleryTextOverlayView.label.text
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.numberOfLines = 0
        label.sizeToFit()
        label.frame.size.width = width
        label.frame.origin.y += padding
        return label.frame
    }

    func getTextOverlayViewFrame(labelFrame:CGRect) -> CGRect {
        let padding:CGFloat = 10.0

        let width = labelFrame.size.width + (padding * 2)
        let height = labelFrame.size.height + (padding * 2)
        let size = CGSize(width: width, height: height)

        let x:CGFloat = 100.0
        let y:CGFloat = self.showTextOverlayButton.center.y - (height / 2)
        let origin = CGPoint(x: x, y: y)

        let frame:CGRect = CGRect(origin: origin, size: size)
        return frame
    }

    func updateBigDocument(html:HtmlDocument) {
        let request = html.getNSURLRequest()
        self.bigDocument.loadRequest(request)
    }

    private func reloadGallery() {
        self.thumbnailCollection.reloadData()
    }

    // MARK: - Collection view data source
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let images = self.currentGallery?.images{
            return images.count
        }
        return 0
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as ThumbnailCollectionViewCell
        cell.imageView?.image = self.getThumbnailImageFromGallery(self.currentGallery!, index: indexPath.row)
        cell.backgroundColor = UIColor.blueColor()
        return cell
    }

    private func getThumbnailImageFromGallery(gallery:MenuItemGallery, index:Int) -> UIImage {
        let galleryImages:[GalleryImage] = self.currentGallery!.images!
        let galleryImage:GalleryImage = galleryImages[index]

        if galleryImage.thumbnail != nil { // prevent crash if image not found
            return galleryImage.thumbnail!
        } else {
            return UIImage(named: "01-tmb-404")!
        }
    }

    // MARK: - Collection view delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.galleryTextOverlayView.hidden = true
        self.currentImageIndex = indexPath.row
        self.showImageOrDocument()
    }

    private func showImageOrDocument() {
        if let galleryImages = self.currentGallery!.images? {
            if let image:GalleryImage? = galleryImages[self.currentImageIndex] as GalleryImage? {
                if (image!.itemType == GalleryItemType.Document) {
                    self.updateBigDocument(image!.html!)
                } else {
                    self.updateBigPicture(self.getFullsizeImageFromGallery(self.currentGallery!, index: self.currentImageIndex))
                }
            } else {
                self.updateBigPicture(self.getFullsizeImageFromGallery(self.currentGallery!, index: self.currentImageIndex))
            }
        } else {
            self.updateBigPicture(self.getFullsizeImageFromGallery(self.currentGallery!, index: self.currentImageIndex))
        }
    }

    private func getFullsizeImageFromGallery(gallery:MenuItemGallery, index:Int) -> UIImage {
        let galleryImages:[GalleryImage] = self.currentGallery!.images!
        let galleryImage:GalleryImage = galleryImages[index]

        if galleryImage.fullsize != nil { // prevent crash if image not found
            return galleryImage.fullsize!
        } else {
            return UIImage(named: "01-404")!
        }
    }

    // MARK: - Gesture Recognizer Delegate

    // this allows a tap on the web view to work
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
            return true
    }

    // MARK: - Gesture Recognizer Actions

    func bigViewTapped(){
        goToFullScreen(self.currentGallery!, index: self.currentImageIndex)
    }

    func thumbnailDoubleTapped(sender: UITapGestureRecognizer){
        if(sender.state == UIGestureRecognizerState.Ended){
            let point: CGPoint = sender.locationInView(thumbnailCollection)
            let indexPath = thumbnailCollection.indexPathForItemAtPoint(point)
            if((indexPath) != nil){
                goToFullScreen(self.currentGallery!, index: indexPath!.row)
            }
        }
    }


    // MARK: - Externally Available Functions
    func showGallery(gallery:MenuItemGallery) {
        self.thumbnailCollection.setContentOffset(CGPointZero, animated: false)
        self.currentGallery = gallery
        self.reloadGallery()

        let galleryImages:[GalleryImage] = self.currentGallery!.images!
        let galleryImage:GalleryImage = galleryImages[currentImageIndex]

        var index = currentImageIndex + 1
        if(index >= self.thumbnailCollection.numberOfItemsInSection(0)){
            index = currentImageIndex
        }
        self.thumbnailCollection.scrollToItemAtIndexPath(NSIndexPath(forRow: index, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)

        self.bigPictureLabel.text = self.getImageTitle()

        self.showImageOrDocument()
    }

    // MARK: - IBActions
    @IBAction func showTextOverlayButtonPressed(sender: AnyObject) {
        if (self.galleryTextOverlayView.hidden == false) {
            self.galleryTextOverlayView.hidden = true
        } else {
            // open it
            if (self.galleryTextOverlayView.label.text != "") {
                self.galleryTextOverlayView.hidden = false
                self.showTextOverlay()
            }
        }
    }

    // MARK: - UIWebView Delegate
    func webViewDidFinishLoad(webView: UIWebView) {
        self.bigDocumentView.frame = self.bigView.frame
        self.bigDocumentView.hidden = false
    }
    
}
