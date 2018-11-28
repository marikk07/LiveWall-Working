//
//  Wallpaper.swift
//  LiveWallpapers
//
//  Created by Vladyslav Gamalii on 9/23/18.
//  Copyright © 2018 Codex. All rights reserved.
//

import UIKit

struct Wallpapers {
    
    // MARK: - Properties
    
    static var all: [Wallpaper] = Wallpapers.readAll()
    
    static var featured: [Wallpaper] {
        let featured = Wallpapers.all.filter { (wallpaper) -> Bool in
            return featuredStrings.contains(wallpaper.name)
        }
        return featured
    }
    
    static var abstract: [Wallpaper] {
        let abstract = Wallpapers.all.filter { (wallpaper) -> Bool in
            return abstractStrings.contains(wallpaper.name)
        }
        return abstract
    }
    
    static var popular: [Wallpaper] {
        let popular = Wallpapers.all.filter { (wallpaper) -> Bool in
            return popularStrings.contains(wallpaper.name)
        }
        return popular
    }
    
    static var special: [Wallpaper] {
        let special = Wallpapers.all.filter { (wallpaper) -> Bool in
            return specialStrings.contains(wallpaper.name)
        }
        return special
    }
    
    static var space: [Wallpaper] {
        let space = Wallpapers.all.filter { (wallpaper) -> Bool in
            return spaceStrings.contains(wallpaper.name)
        }
        return space
    }
    
    static var shapes: [Wallpaper] {
        let shapes = Wallpapers.all.filter { (wallpaper) -> Bool in
            return shapesStrings.contains(wallpaper.name)
        }
        return shapes
    }
    
    static var sciFi: [Wallpaper] {
        let sciFi = Wallpapers.all.filter { (wallpaper) -> Bool in
            return sciFiStrings.contains(wallpaper.name)
        }
        return sciFi
    }
    
    static var footage: [Wallpaper] {
        let footage = Wallpapers.all.filter { (wallpaper) -> Bool in
            return footageStrings.contains(wallpaper.name)
        }
        return footage
    }
    
    // MARK: - Private properties
    
    private static let featuredStrings = ["LW76", "LW82", "LW85", "LW103", "LW109", "LW111", "LW156", "LW168", "LW169", "LW178", "LW208", "LW209", "LW220", "LW227", "LW230", "LW232"]
    
    private static let abstractStrings: [String] = ["LW74", "LW76", "LW77","LW82","LW86","LW96","LW102","LW103","LW118","LW120","LW126","LW128","LW135","LW147","LW148","LW150","LW155","LW159","LW176","LW177","LW182","LW190","LW222","LW225","LW230","LW235","LW251"]
    
    private static let popularStrings: [String] = ["LW92","LW93","LW94","LW100","LW110","LW112","LW117","LW118","LW128","LW133","LW137","LW144","LW150","LW151","LW166","LW170","LW175","LW191","LW193","LW198","LW231","LW246"]
    
    private static let specialStrings: [String] = ["LW91","LW92","LW93","LW96","LW110","LW117","LW119","LW130","LW140","LW148","LW150","LW161","LW162","LW184","LW188","LW194","LW195","LW225","LW232","LW238","LW252"]
    
    private static let spaceStrings: [String] = ["LW152","LW166","LW178","LW180","LW191","LW232","LW233"]
    
    private static let shapesStrings: [String] = ["LW73","LW74","LW76","LW81","LW98","LW100","LW102","LW105","LW106","LW107","LW112","LW114","LW125","LW134","LW137","LW138","LW141","LW142","LW143","LW146","LW149","LW168","LW170","LW182","LW183","LW195","LW202","LW205","LW207","LW208","LW209","LW210","LW217","LW218","LW241"]
    
    private static let sciFiStrings: [String] = ["LW77","LW94","LW110","LW115","LW130","LW139","LW142","LW157","LW158","LW175","LW183","LW192","LW194","LW199","LW231","LW236","LW237","LW249"]
    
    private static let footageStrings: [String] = ["LW84","LW85","LW90","LW93","LW95","LW101","LW104","LW108","LW122","LW123","LW132","LW133","LW144","LW145","LW165","LW169","LW239"]
    
    // MARK: - Private methods
    
    private static func readAll() -> [Wallpaper] {
        guard let path = Bundle.main.path(forResource: "List", ofType: "plist") else { return [] }
        let url = URL.init(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url) else { return [] }
        guard let json = try? PropertyListSerialization.propertyList(from: data, options: PropertyListSerialization.ReadOptions.mutableContainers, format: nil) as! [[String:String]] else { return [] }
        let wallpapers = json.compactMap(parseWallpapers)
        return wallpapers
    }
    
    private static func parseWallpapers(_ item: [String : String]) -> Wallpaper? {
        guard let fileName = item["fileName"] else { return nil }
        return Wallpaper(name: fileName, imageName: "\(fileName).JPG")
    }
}

struct Wallpaper {
    var name: String
    var imageName: String
    var image: UIImage {
        return UIImage.init(named: imageName) ?? #imageLiteral(resourceName: "test")
    }
    
}
