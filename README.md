# Movie Time App

A simple master-detail application demo that pulls data from iTunes Search API.

## Design Pattern

I used a somewhat hybrid approach or MVVM and MVC. Hybrid in the sense that the `View` doesn't have bindings to the `ViewModel`. The `ViewModel` doesn't listen for `Model` changes. The `View` updates itself imperatively based on triggers emmited by the `ViewController` which is also part of the `View` layer.

It's not the perfect MVVM but it still has clear separation of concerns.

### Model (M)

Models are separate structs, e.g. an object representation of a JSON response.

### Views (V)

My view layer includes the storyboard, classes that extends `UIView`, and the `ViewController`. In traditional Apple MVC the `ViewController` does everything. In my approach I limit the `ViewController` to handle UI related stuffs only.

### ViewModel/Controller (VM/C)

The ViewModel holds the business logic and any stuff not related to UI and doesn't contain code that updates the UI.

## IB, Storyboards, Groupings

I use the "Skeletal Storyboard" approach as define by Sean Allen in [this video](https://www.youtube.com/watch?v=hIQMQmzitfU). I like this approach because it's easy to check in code which property of a view you have changed. Compared to figuring out what has changed on the inspectors panel.

Combined with Swift's property observer, you can do view initialization inside your `@IBOutlet` declaration.

```swift
@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView! {
    didSet {
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.stopAnimating()
    }
}
```

I still to layout constraints in **IB** because it's easier there. Managing constraints in code is awful.

I group my related view code per screen, together with the `ViewModel`. I use storyboard references instead of stuffing the storyboard with `ViewControllers`, so that managing git diffs wouldn't be a nightmare.

## Screenshots

### Master screen

![Master screen](https://raw.githubusercontent.com/mdegamo/movie-time-demo/master/Screenshots/master-screen.png)

For the master screen, I grouped the movies per genre. 2 special groups are also added on top. "Favorites" for user defined favorite movies, and "Featured", which are just random picks. Each group (on this screen), except "Favorites" has a max of 10 movies.

Tapping the "View all" button will open up the "Collection screen". Tapping the thumbnail opens the "Detail screen".

The "Favorites" collection is persistent. The app remembers your *favorited* movies even after relaunching the app.

### Collection screen

![Collection screen](https://raw.githubusercontent.com/mdegamo/movie-time-demo/master/Screenshots/collection-list-screen.png)

Lists all the movies in a collection, with slightly larger thumbnails.

### Detail screen

![Detail screen](https://raw.githubusercontent.com/mdegamo/movie-time-demo/master/Screenshots/detail-screen.png)

Shows the complete movie detail. Info includes Title, Artist, Genre, Price, Long description and the movie poster. Tapping the "heart" button will add or remove that movie from the "Favorites" collection.