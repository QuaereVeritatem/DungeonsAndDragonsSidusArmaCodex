//
//  BaseUrl.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/19/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
// This is the base url (website) which we make calls to for data
// Work around for unsecured websites (http) can be found here ->
// https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http  and here - >
// https://i.stack.imgur.com/LqXFE.png

import Foundation

// original BaseUrl is http://dnd5eapi.co/api/

// This is the list of all weapons starting url
//     [This will be a different model than the WeaponUrl]
let BaseUrl: String = "https://www.dnd5eapi.co/api/equipment-categories/weapon/"

// This is the weapon details starting Url...complete Url will be WeaponUrl + url(from weaponList.url..json retrieve)
let WeaponUrl: String = "http://dnd5eapi.co"

//original weaponUrl
//let WeaponUrl: String = "http://dnd5eapi.co/api/equipment/"

//weapon direct urls for each weapon (this a cheat and we will need to take in all equipment then sort by categories into diff models
let weapDirectUrls = [
    URL(string: "https://www.dnd5eapi.co/api/equipment/club"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/dagger"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/greatclub"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/handaxe"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/javelin"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/light-hammer"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/mace"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/quarterstaff"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/sickle"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/spear"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/crossbow-light"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/dart"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/shortbow"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/sling"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/battleaxe"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/flail"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/glaive"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/greataxe"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/greatsword"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/halberd"),
    URL(string: "https://www.dnd5eapi.co/api/equipment/lance")
]
