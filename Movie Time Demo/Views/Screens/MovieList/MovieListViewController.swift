//
//  ViewController.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    let restApi = RestApi()
    
    @IBAction func getAllMovies(_ sender: Any) {
        restApi.getMovies(onSuccess: { movies in
           Log.debug("Get Movies Success")
        }, onError: { error in
            Log.debug("Get Movies Error")
        }, onComplete: {
            Log.debug("Get Movies Complete")
        })
    }
    
    @IBAction func getSpecific(_ sender: Any) {
        restApi.getMovie(byId: 1, onSuccess: { movie in
            Log.debug("Get Specific Movie Success")
        }, onError: { error in
            Log.debug("Get Specific Movie Error")
        }, onComplete: {
            Log.debug("Get Specific Movie Complete")
        })
    }
}

