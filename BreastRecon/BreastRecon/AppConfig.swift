//
//  AppConfig.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 11/3/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import Foundation
import UIKit

private let _AppConfigSharedInstance = AppConfig()

class AppConfig {
    
    private let keyBaseColors:String = "basecolors"
    private let keyItemColors:String = "itemcolors"
    private let keyColorComponentRed:String = "red"
    private let keyColorComponentGreen:String = "green"
    private let keyColorComponentBlue:String = "blue"
    private let keyColorComponentAlpha:String = "alpha"
    private let keyColorComponentHex:String = "hex"
    
    private let keyColorWhite:String = "white"
    private let keyColorBlack:String = "black"
    private let keyColorPink:String = "pink"
    private let keyColorTeal:String = "teal"
    private let keyColorGray:String = "gray"
    private let keyColorCream:String = "cream"
    private let keyColorBrown:String = "brown"
    private let keyColorLtBrown:String = "lt_brown"
    private let keyColorDarkMauve:String = "dark_mauve"
    
    private let keyColorMaidenBlush:String = "maiden_blush"
    private let keyColorBloodBomb:String = "blood_bomb"
    private let keyColorBridesmaid:String = "bridesmaid"
    private let keyColorNeptune:String = "neptune"
    private let keyColorMarbleFlesh:String = "marble_flesh"
    private let keyColorTongue:String = "tongue"
    private let keyColorConanObrien:String = "conan_obrien"
    private let keyColorDyingSakura:String = "dying_sakura"
    private let keyColorCharcoal:String = "charcoal"
    private let keyColorAbeVigoda:String = "abe_vigoda"
    private let keyColorCuticle:String = "cuticle"
    private let keyColorDune:String = "dune"
    private let keyColorPoolHair:String = "pool_hair"
    private let keyColorAlgae:String = "algae"
    private let keyColorGangrene:String = "gangrene"
    private let keyColorLipstick:String = "lipstick"
    private let keyColorHotPink:String = "hot_pink"
    private let keyColorMaroon:String = "maroon"
    
    private let keyColorItem_MenuSeperator:String = "menu_seperator"
    private let keyColorItem_TextDefault_foreground:String = "textDefault_foreground"
    private let keyColorItem_MenuBackground:String = "menu_background"
    private let keyColorItem_MenuItemLabel_foreground:String = "menuItemLabel_foreground"
    private let keyColorItem_MenuItem_background:String = "menuItem_background"
    private let keyColorItem_MenuItem_selected:String = "menuitem_selected"
    private let keyColorItem_MenuSubItem_selected:String = "menuSubItem_selected"
    private let keyColorItem_MenuItemLabel_selected:String = "menuItemLabel_selected"
    private let keyColorItem_MenuItemIcon_normal:String = "menuItemIcon_normal"
    private let keyColorItem_MenuItemIcon_selected:String = "menuItemIcon_selected"
    private let keyColorItem_MenuNavBar_background:String = "menuNavBar_background"
    private let keyColorItem_ImageBorder_background:String = "imageBorder_background"
    private let keyColorItem_Thumbnail_background:String = "thumbnail_background"
    private let keyColorItem_Thumbnail_border:String = "thumbnail_border"
    private let keyColorItem_MenuNavBar_Text:String = "menu_navbar_text"
    private let keyColorItem_ImageTitle_Text:String = "image_title_text"
    private let keyColorItem_ImageButton:String = "image_button"

    
    private let keyFonts:String = "fonts"
    private let keyFontDefault:String = "default"
    private let keyFontStyleRegular:String = "regular"
    private let keyFontStyleBold:String = "bold"
    private let keyFontStyleItalic:String = "italic"
    private let keyFontStyleBoldItalic:String = "bold_italic"
    
    private let defaultColor = UIColor.blackColor()
    private let keyPaths = "paths"
    private let keyDocumentsPath = "documents_path"
    private let keyFullSizePath = "fullsize_path"
    private let keythumbnailsPath = "thumbnails_path"
    
    private var dictConfig:NSDictionary?
    private var dictBaseColors:NSDictionary?
    private var dictItemColors:NSDictionary?
    private var dictFonts:NSDictionary?
    private var dictPaths :NSDictionary?
 
    class var sharedInstance: AppConfig {
        return _AppConfigSharedInstance
    }
    
    init() {
        self.dictConfig = self.readConfigFile("AppConfig")
        self.dictPaths = self.dictConfig?[self.keyPaths] as? NSDictionary
        self.dictBaseColors = self.dictConfig?.objectForKey(self.keyBaseColors) as? NSDictionary
        self.dictItemColors = self.dictConfig?.objectForKey(self.keyItemColors) as? NSDictionary
        self.dictFonts = self.dictConfig?.objectForKey(self.keyFonts) as? NSDictionary
    }
    
    private func readConfigFile(configFilename:String) -> NSDictionary {
        var filetype:String = "plist"
        var configFile:NSDictionary = NSDictionary()
        if let configFilePath = NSBundle.mainBundle().pathForResource(configFilename, ofType: filetype) {
            configFile = NSMutableDictionary(contentsOfFile: configFilePath)!
        }
        return configFile
    }
    
    private func getBaseColorFromDictionary(colorNameKey:String) -> UIColor {
        let colorDefinition:NSDictionary = self.dictBaseColors?.objectForKey(colorNameKey) as NSDictionary
        let redComponent:Int = (colorDefinition.objectForKey(keyColorComponentRed) as String).toInt()!
        let greenComponent:Int = (colorDefinition.objectForKey(keyColorComponentGreen) as String).toInt()!
        let blueComponent:Int = (colorDefinition.objectForKey(keyColorComponentBlue) as String).toInt()!
        let alphaComponent:Int = (colorDefinition.objectForKey(keyColorComponentAlpha) as String).toInt()!
        let color = UIColor(
            red:self.convertColorValue(redComponent),
            green:self.convertColorValue(greenComponent),
            blue:self.convertColorValue(blueComponent),
            alpha:CGFloat(alphaComponent)
        )
        return color
    }
    
    private func convertColorValue(intValue:Int) -> CGFloat {
        let value:CGFloat = CGFloat(intValue)
        let maxValue:CGFloat = CGFloat(255)
        let convertedValue:CGFloat = CGFloat(value/maxValue)
        return convertedValue
    }
    
    private func getUIFont(name:String, style:String, size:CGFloat) -> UIFont {
        
        let fontName:String = self.dictFonts?[name] as String
        let fontDescriptor = UIFontDescriptor(name: fontName, size: size)
        let boldFontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold)
        let italicFontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitItalic)
        let bolditalicFontDescriptor = fontDescriptor.fontDescriptorWithSymbolicTraits(UIFontDescriptorSymbolicTraits.TraitBold | UIFontDescriptorSymbolicTraits.TraitItalic)
        
        var font:UIFont;
        switch style.lowercaseString {
            case keyFontStyleBold:
                font = UIFont(descriptor: boldFontDescriptor, size: size)
            case keyFontStyleItalic:
                font = UIFont(descriptor: italicFontDescriptor, size: size)
            case keyFontStyleBoldItalic:
                font = UIFont(descriptor: bolditalicFontDescriptor, size: size)
            default:
                font = UIFont(name: fontName, size: size)!
        }
        
        return font
    }
    
    // -------------------------------------------------------
    // MARK: - BASE COLORS
    // -------------------------------------------------------
    func basecolor_white() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorWhite)
    }
    func basecolor_black() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorBlack)
    }
    func basecolor_pink() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorPink)
    }
    func basecolor_teal() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorTeal)
    }
    func basecolor_brown() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorBrown)
    }
    func basecolor_cream() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorCream)
    }
    func basecolor_gray() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorGray)
    }
    func basecolor_lt_brown() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorLtBrown)
    }
    func basecolor_dark_mauve() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorDarkMauve)
    }
    func basecolor_maiden_blush() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorMaidenBlush)
    }
    func basecolor_blood_bomb() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorBloodBomb)
    }
    func basecolor_bridesmaid() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorBridesmaid)
    }
    func basecolor_neptune() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorNeptune)
    }
    func basecolor_marble_flesh() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorMarbleFlesh)
    }
    func basecolor_tongue() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorTongue)
    }
    func basecolor_conan_obrien() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorConanObrien)
    }
    func basecolor_dying_sakura() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorDyingSakura)
    }
    func basecolor_charcoal() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorCharcoal)
    }
    func basecolor_abe_vigoda() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorAbeVigoda)
    }
    func basecolor_cuticle() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorCuticle)
    }
    func basecolor_dune() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorDune)
    }
    func basecolor_pool_hair() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorPoolHair)
    }
    func basecolor_algae() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorAlgae)
    }
    func basecolor_gangrene() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorGangrene)
    }
    func basecolor_lipstick() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorLipstick)
    }
    func basecolor_hot_pink() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorHotPink)
    }
    func basecolor_maroon() -> UIColor {
        return self.getBaseColorFromDictionary(keyColorMaroon)
    }

    
    
    // -------------------------------------------------------
    // MARK: - FONTS
    // -------------------------------------------------------
    func font_default_regular(size:CGFloat) -> UIFont {
        return self.getUIFont(self.keyFontDefault, style: self.keyFontStyleRegular, size: size)
    }
    
    func font_default_bold(size:CGFloat) -> UIFont {
        return self.getUIFont(self.keyFontDefault, style: self.keyFontStyleBold, size: size)
    }
    
    func font_default_italic(size:CGFloat) -> UIFont {
        return self.getUIFont(self.keyFontDefault, style: self.keyFontStyleItalic, size: size)
    }
    
    func font_default_bolditalic(size:CGFloat) -> UIFont {
        return self.getUIFont(self.keyFontDefault, style: self.keyFontStyleBoldItalic, size: size)
    }
    
    func getDocumentPath() -> String{
        return self.dictPaths?[keyDocumentsPath] as String
    }
    
    func getFullSizePath() -> String{
        return self.dictPaths?[keyFullSizePath] as String
    }
    
    func getThumbnailPath() -> String{
        return self.dictPaths?[keythumbnailsPath] as String
    }
    
    
    // -------------------------------------------------------
    // MARK: - APPLICATION ITEM COLORS
    // -------------------------------------------------------
    func menu_seperator() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuSeperator) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menu_background() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuBackground) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItem_background() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItem_background) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItemLabel_foreground() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItemLabel_foreground) as String
        return self.getBaseColorFromDictionary(key)
    }
    func textDefault_foreground() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_TextDefault_foreground) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItem_selected() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItem_selected) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuSubItem_selected() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuSubItem_selected) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItemLabel_selected() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItemLabel_selected) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuNavBar_background() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuNavBar_background) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItem_icon_normal() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItemIcon_normal) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menuItem_icon_selected() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuItemIcon_selected) as String
        return self.getBaseColorFromDictionary(key)
    }
    func imageBorder_background() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_ImageBorder_background) as String
        return self.getBaseColorFromDictionary(key)
    }
    func thumbnail_background() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_Thumbnail_background) as String
        return self.getBaseColorFromDictionary(key)
    }
    func thumbnail_border() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_Thumbnail_border) as String
        return self.getBaseColorFromDictionary(key)
    }
    func menu_navbar_text() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_MenuNavBar_Text) as String
        return self.getBaseColorFromDictionary(key)
    }
    func image_title_text() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_ImageTitle_Text) as String
        return self.getBaseColorFromDictionary(key)
    }
    func image_button() -> UIColor {
        let key:String = self.dictItemColors?.objectForKey(keyColorItem_ImageButton) as String
        return self.getBaseColorFromDictionary(key)
    }
}