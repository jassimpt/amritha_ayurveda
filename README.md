# Amritha Ayurveda 🌿

A modern, user-friendly Flutter application for booking Ayurveda treatments and managing appointments with a seamless user experience.

## Overview

Amritha Ayurveda is a comprehensive mobile application designed to bridge the gap between traditional Ayurvedic healing and modern technology. Users can easily browse treatments, book appointments, and manage their wellness journey through an intuitive and elegant interface.

## Features ✨

- **Treatment Booking**: Browse and book various Ayurvedic treatments
- **Modern UI/UX**: Clean, intuitive design with smooth animations
- **Appointment Management**: View, modify, and track your appointments
- **Invoice Generation**: Get detailed invoices for your bookings
- **User-Friendly Interface**: Easy navigation suitable for all age groups
- **Secure & Reliable**: Built with Flutter for cross-platform compatibility

## Getting Started

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)
- Android SDK
- iOS development tools (for iOS deployment)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/amritha_ayurveda.git
   cd amritha_ayurveda
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   # For development
   flutter run
   
   # For release build
   flutter run --release
   ```

### Building for Production

#### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

#### iOS
```bash
flutter build ios --release
```

## Download App 📱

### Android
- [Download APK](your-download-link-here)
- [Google Play Store](your-play-store-link)

### iOS
- [App Store](your-app-store-link)

*Replace the links above with your actual download URLs*

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/
│   ├── service/
│   ├── utils/
│   └── widgets/
└── features/
    ├── auth/
    │   ├── controller/
    │   ├── model/
    │   ├── service/
    │   ├── widgets/
    │   └── login_screen.dart
    ├── home/
    │   ├── controller/
    │   ├── model/
    │   ├── service/
    │   ├── widgets/
    │   └── home_screen.dart
    ├── register/
    │   ├── controller/
    │   ├── models/
    │   ├── service/
    │   ├── widgets/
    │   └── register_screen.dart
    └── splash/
        └── splash_screen.dart
```

The project follows a **clean architecture** with **feature-first organization**:

- **`core/`** - Shared utilities, constants, services, and reusable widgets
- **`features/`** - Feature-specific modules with MVC pattern:
  - **`controller/`** - Business logic and state management
  - **`model/`** - Data models and entities
  - **`service/`** - API calls and data services
  - **`widgets/`** - Feature-specific UI components
  - **`*_screen.dart`** - Main screen files
- **`main.dart`** - Application entry point

This modular structure promotes code reusability, maintainability, and follows clean architecture principles.

## Dependencies

Key packages used in this project:

- **`dio`** (^5.8.0+1) - HTTP client for API requests
- **`shared_preferences`** (^2.3.3) - Local data storage
- **`provider`** (^6.1.5+1) - State management solution
- **`google_fonts`** (^6.3.0) - Custom fonts integration
- **`enefty_icons`** (^1.0.8) - Modern icon library
- **`intl`** (^0.20.2) - Internationalization and date formatting
- **`pdf`** (^3.11.3) - PDF generation for invoices
- **`path_provider`** (^2.1.5) - File system path access
- **`open_filex`** (^4.7.0) - File opening functionality
- **`rename`** (^3.1.0) - Development tool for project renaming

## Contributing

We welcome contributions to improve Amritha Ayurveda! Please follow these steps:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support

For support and inquiries, feel free to reach out:

- **Email**: jassimmuthu990@gmail.com
- **Alternative Email**: letters2jassim@gmail.com
- **Phone**: +91-9961666937
- **LinkedIn**: [linkedin.com/in/jassimpt](https://www.linkedin.com/in/jassimpt/)

You can also create an issue in this repository for bug reports or feature requests.

---

**Made with ❤️ using Flutter**

*Bringing ancient wisdom to modern fingertips*