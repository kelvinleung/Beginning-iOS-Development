//
//  ViewController.swift
//  DialogViewer
//
//  Created by Kelvin Leung on 30/09/2017.
//  Copyright © 2017 Kelvin Leung. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private var sections = [
        ["header": "First Witch",
         "content" : "Hey, when will the three of us meet up later?"],
        ["header" : "Second Witch",
         "content" : "When everything's straightened out."],
        ["header" : "Third Witch",
         "content" : "That'll be just before sunset."],
        ["header" : "First Witch",
         "content" : "Where?"],
        ["header" : "Second Witch",
         "content" : "The dirt patch."],
        ["header" : "Third Witch",
         "content" : "I guess we'll see Mac there."]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.register(ContentCell.self, forCellWithReuseIdentifier: "Content")
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        var contentInset = collectionView!.contentInset
        contentInset.top = 20
        collectionView!.contentInset = contentInset
        
        let layout = collectionView!.collectionViewLayout
        let flow = layout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 20)
        flow.headerReferenceSize = CGSize(width: 100, height: 25)
    }
    
    func wordsInSection(section: Int) -> [String] {
        let content = sections[section]["content"]
        let spaces = NSCharacterSet.whitespacesAndNewlines
        let words = content?.components(separatedBy: spaces)
        return words!
    }
    
}

extension ViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let words = wordsInSection(section: section)
        return words.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let words = wordsInSection(section: indexPath.section)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Content", for: indexPath) as! ContentCell
        cell.maxWidth = collectionView.bounds.size.width
        cell.text = words[indexPath.row]
        return cell
    }
    
}

extension ViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let words = wordsInSection(section: indexPath.section)
        print(words[indexPath.row])
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let words = wordsInSection(section: indexPath.section)
        let size = ContentCell.sizeForContentString(s: words[indexPath.row], forMaxWidth: collectionView.bounds.size.width)
        return size
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath) as! HeaderCell
            cell.maxWidth = collectionView.bounds.size.width
            cell.text = sections[indexPath.section]["header"]
            return cell
        }
        abort()
    }
    
}
