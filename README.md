# Running
Open project in Xcode, Build and Run MoviesApp target using an iPhone simulator. To run on the device sign the app with your development team. Tested on an iPhone 11 but should look ok on all devices.

# Architecture - Patterns

## MVVM
The project is architected using the Model-View-ViewModel pattern. The business logic comes from the model, in this case that is the `MovieSearchResult` struct and the `MovieSearchPublisher`. The `MovieSearchViewModel` translates the model data into a form that can be easily presented by the `MovieSearchView`

## Publisher
The `MovieSearchPublisher` uses Combine to publish an array of Movies from search or an Error. Publisher was chosen for this project so that the UI will immediately update with any changes to the value of the publisher: as the search query changes

## Codable
The project uses Swift's Codable to convert the JSON payload received from the server into Swift structs. Decoding will throw an error if a non-optional property is missing from the response or if there is a type mismatch between the response type and the struct propery type.
Codable lets us persist the watch list using UserDefaults

# Questions

## Most difficult task
The most difficult tasks were learning new ways to do things in SwiftUI that are more trivial in UIKit. For example, I had to create `GreedyTextView` which wraps UITextField in order to have a text view immediately become first responder.

## What I learned
I'm always learning more about SwiftUI, when writing `AsyncImageView` I learned that SwiftUI views are quite powerful and dynamic. In this case the image view displays a placeholder until the image is loaded in from the network.

## What I didn't have time to add
When the user taps on a movie in their watch list, they are pushed to a detail view. I wanted this detail view to make an additional API call to get additional metadata like user rating, runtime, etc. but didn't have time to implement it. I also wanted the confirmation toast to look better, but visual effect (blur) views are not built into SwiftUI and would need UIKit adapters.

## How the app could be improved
The app could be improved by allowing multiple watch lists to be created, displaying user ratings and additional metadata on the detail page, and creating a link to buy the movie by finding the movie on iTunes using the IDMB ID.

# Time

I spent around 4 hours on this project
