# CastLink

CastLink is a modern Flutter application that provides video casting and streaming capabilities. Built with Flutter and GetX for state management, it offers a seamless cross-platform experience.

## Features

- Video playback and casting functionality
- Dark/Light theme support
- Cross-platform compatibility (Android, iOS, Web, Windows, Linux, macOS)
- Modern Material 3 design
- Persistent storage using GetStorage
- Responsive UI with Google Fonts

## Prerequisites

- Flutter SDK (>=3.2.3)
- Dart SDK (>=3.2.3)
- Android Studio / VS Code with Flutter extensions
- Git

## Getting Started

1. Clone the repository:
```bash
git clone [your-repository-url]
cd castlink
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── app/
│   ├── controllers/    # GetX controllers
│   ├── modules/        # Feature modules
│   └── ...
├── routes/            # App routes
└── main.dart          # Entry point
```

## Dependencies

- **get**: ^4.6.6 - State management and routing
- **get_storage**: ^2.1.1 - Local storage
- **video_player**: ^2.8.2 - Video playback
- **chewie**: ^1.7.5 - Video player UI
- **google_fonts**: ^6.1.0 - Custom fonts
- **floating**: ^6.0.0 - Floating widgets

## Development

The project uses:
- GetX for state management and routing
- Material 3 design system
- Flutter Lints for code quality
- Flutter Launcher Icons for app icons

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

### Windows
```bash
flutter build windows --release
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- GetX team for the powerful state management solution
- All contributors who have helped shape this project
