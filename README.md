# YouApp

YouApp is a modern application consisting of two main parts: **YouApp Backend** (an API server based on NestJS) and **YouApp Mobile** (a cross-platform mobile application based on Flutter). This app is designed to provide an interactive, secure, and easily accessible user experience across various devices.

## Main Features
- **Authentication & Authorization**: Login/register system with JWT for user data security.
- **Real-Time Chat**: Instant communication between users using RabbitMQ.
- **User Management**: CRUD profile, account settings, and other social features.
- **Modular Architecture**: Well-structured backend and mobile code, easy to develop and maintain.

## Tech Stack

### Backend (youapp_backend)
- **NestJS**: Progressive Node.js framework for building scalable and maintainable backend applications.
- **TypeScript**: Main language for backend development, providing type safety and high productivity.
- **WebSocket**: For real-time chat features.
- **JWT (JSON Web Token)**: For secure authentication and authorization.
- **Docker**: Supports consistent deployment and development across different environments.

### Mobile (youapp_mobile)
- **Flutter**: Google's UI framework for building cross-platform mobile applications (Android, iOS, Web, Desktop) from a single codebase.
- **Dart**: Main programming language for Flutter.
- **Provider**: Efficient and easy-to-use state management.
- **API Integration**: Communication with backend using HTTP/REST API.

## Project Structure
```
youapp_backend/   # Backend source code (NestJS)
youapp_mobile/    # Mobile application source code (Flutter)
```

## How to Run
### Backend
1. Go to the `youapp_backend` folder
2. Install dependencies: `npm install`
3. Start the server: `npm run start:dev`

### Mobile
1. Go to the `youapp_mobile` folder
2. Install dependencies: `flutter pub get`
3. Run the application: `flutter run`

## Contribution
Contributions are very welcome! Please fork this repository, create a new branch, and submit a pull request.

---

**YouApp** – A modern, fast, and flexible application solution for your needs!