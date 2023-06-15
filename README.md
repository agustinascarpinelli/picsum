# README - Flutter Application for PICSUM

This is a Flutter application called PICSUM that allows users to login with a valid email and the password "123456". Upon logging in, users can view a list of photos fetched from the [PICSUM API](https://picsum.photos/). The application provides the ability to switch between dark and light themes and to logout. By tapping on each photo, users can view the photo, zoom in, and access various details. The details include a link to open the web page of the photo and an option to download the photo to the device.

## Dependencies

The project uses the following dependencies:

- [bloc](https://pub.dev/packages/bloc): ^8.1.2
- [cupertino_icons](https://pub.dev/packages/cupertino_icons): ^1.0.2
- [dartz](https://pub.dev/packages/dartz): ^0.10.1
- [flutter](https://flutter.dev/): sdk: flutter
- [flutter_bloc](https://pub.dev/packages/flutter_bloc): ^8.1.3
- [flutter_downloader](https://pub.dev/packages/flutter_downloader): ^1.10.4
- [google_fonts](https://pub.dev/packages/google_fonts): ^5.0.0
- [http](https://pub.dev/packages/http): ^1.0.0
- [path_provider](https://pub.dev/packages/path_provider): ^2.0.15
- [permission_handler](https://pub.dev/packages/permission_handler): ^10.3.0
- [photo_view](https://pub.dev/packages/photo_view): ^0.14.0
- [provider](https://pub.dev/packages/provider): ^6.0.5
- [url_launcher](https://pub.dev/packages/url_launcher): ^6.1.11

## Features

- User authentication with a valid email and password.
- Dark and light theme options.
- Displaying a list of photos from the PICSUM API.
- Zooming in on photos.
- Viewing photo details.
- Opening the web page of a photo.
- Downloading photos to the device.

## Getting Started

To get started with the PICSUM application, follow these steps:

1. Make sure you have the Flutter SDK installed on your development environment. You can find more information on how to install Flutter at [flutter.dev](https://flutter.dev/docs/get-started/install).
2. Clone the PICSUM project repository to your local machine.
3. Open the project in your preferred editor or IDE.
4. Run the following command in the project directory to fetch the required dependencies:

   ```bash
   flutter pub get
   ```

5. Once the dependencies are fetched successfully, run the following command to launch the application:

   ```bash
   flutter run
   ```

6. The application will be built and launched on the connected device or emulator.

Please ensure that you have a stable internet connection to fetch the photos from the PICSUM API.

## Project Structure

The project follows a standard Flutter application structure. Here's a brief overview of the main directories and files:

- `lib/`: Contains the source code of the application.
  - `data/`: Contains classes and logic related to data retrieval and manipulation.
  - `models/`: Contains the definitions of data models used in the application.
  - `pages/`: Contains the main screens of the application.
  - `widgets/`: Contains reusable widgets used in the application.
- `assets/`: Contains static assets used in the application, such as images and icons.
- `pubspec.yaml`: The project configuration file where dependencies and other metadata are specified.

Feel free to explore

 the project structure and modify the code to fit your requirements.

## Contributions

Contributions to the PICSUM application are welcome! If you find any issues or have suggestions for improvements, please create a pull request or submit an issue in the project repository.

## License

This project is licensed under the [MIT License](LICENSE).
