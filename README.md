# Photos Fetching and Details App - iOS

This is a simple iOS application that allows the user to fetch photos from an API and insert ad placeholder after every 5 photos, display them in a table view and navigate to the details of the photo when tapped.

The app is developed using MVVM architecture, RxSwift and Alamofire for network requests, SDWebImage for image loading, NVActivityIndicatorView for loading indicators and RxCocoa for binding UI elements.

*Requirements
iOS 16.0+
Xcode 14.0+
Swift 5+

*Installation
Clone the repository.
Open PhotosFetchingAndDetails.xcodeproj.
Build and run the project on your simulator or device.

*Features
Fetches photos from an API using Alamofire.
Displays photos in a collection view using RxSwift and SDWebImage.
Loads a loading indicator when fetching photos.
Implements pagination when the user reaches the end of the collection view.
Caches 20 images using UserDefaults.
Displays photo details when the user taps on a photo using a detail view.
Change background color to the most dominant color of selected photo.
Unit tests for photos view model.

*MVVM Architecture
The app follows MVVM (Model-View-ViewModel) architecture, which separates the responsibilities of the app into three layers:

Model: Contains the data and business logic of the app.
View: Contains the UI elements and user interactions of the app.
ViewModel: Binds the Model and View together and provides the necessary data and actions for the View to render and interact with.
The ViewModel layer is responsible for the business logic of the app, and uses RxSwift to bind the data from the Model layer to the View layer. This way, the ViewModel layer only communicates with the View layer via the data bindings and the View layer never has direct access to the data.

*Network Layer
The app uses Alamofire for making network requests to fetch photos from an API. The NetworkManager class handles the network requests, and returns the response in a Result object which can be either a success or failure case.

*Image Loading
The app uses SDWebImage for loading images asynchronously from URLs. This library provides caching and memory management of images and allows for smooth scrolling of the collection view.

*Loading Indicator
The app uses NVActivityIndicatorView to show a loading indicator while fetching photos.

*Pagination
The app implements pagination when the user reaches the end of the collection view. This way, the app can fetch more photos from the API without fetching all of the photos at once.

*Caching
The app caches 20 images using UserDefaults. This way, the app can show previously loaded images when the user is offline or when there is a network error.

*Conclusion
This app showcases the use of MVVM architecture, RxSwift and Alamofire in a simple photo fetching app. The use of SDWebImage and NVActivityIndicatorView provide a smoother user experience, while caching allows for the app to function offline.
