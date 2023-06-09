# MovieAppChallenge.

Mobile movie application to access a wide selection of movies online.

## Software architecture
### Layered architecture
For the proposed challenge we used a layered architecture, where we tried to separate each important layer such as presentation, business and data. The layers communicate with each other through well-defined interfaces, which allows a clear separation of responsibilities and greater ease of maintenance and scalability of the application.

### Design pattern
In addition to this architecture, the BloC design pattern is used to separate the business logic from the user interface. It also allows the application to react to external events and update the user interface accordingly.

The combination of the layered architecture and the BloC design pattern in Flutter allows for improved modularity and makes the development and maintenance process easier and more scalable.


### Libraries and Technologies

* Flutter: Version  1.0.0+1 
* cupertino_icons: ^1.0.2. Provides a set of icons designed for use in Flutter applications similar in style to those used in Apple products.
* dio: ^3.0.3. Allows you to perform HTTP requests in an easy and efficient way, using a simple and elegant syntax.
* flutter_bloc: ^6.1.2. State manager, uses Bloc pattern
* url_launcher: ^5.2.0. Allows you to open links in an easy and simple way, using a simple and elegant syntax.
* cached_network_image: ^2.0.0-rc. Allows you to efficiently upload images to your application.
* equatable: ^1.2.5. Object comparator in an efficient way in your application
* carousel_slider: ^2.3.1 Implements an image or content slider in your application.
* readmore: ^2.1.0. Implements a "read more" functionality in your application.
* shared_preferences: ^2.0.8. Allows simple data to be stored in the device's memory.




## User interfaces
### Home

<img src="https://user-images.githubusercontent.com/65831134/226102036-ddebfe72-58b3-45c5-aa8e-1e6145716346.jpg" width="250" height="500">

### Favorites

<img src="https://user-images.githubusercontent.com/65831134/226102003-902fce31-1a8d-4a7b-896b-954c11507038.jpg" width="250" height="500">

### Search

<img src="https://user-images.githubusercontent.com/65831134/226102045-67dec764-8f6d-4ae9-864c-0ad815e680ff.jpg" width="250" height="500">

### Detail of a movie

|<img src="https://user-images.githubusercontent.com/65831134/226102023-f83abcfb-3d05-4be8-b393-a249bcf65747.jpg" width="250" height="500"> |  <img src="https://user-images.githubusercontent.com/65831134/226101959-16d5857c-b3e5-4172-a371-92341fe65c3b.jpg" width="250" height="500"> 






For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
