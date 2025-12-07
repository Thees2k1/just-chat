# Just Chat

**A Cross-Platform Real-Time Messaging Application**

## Project Overview
Just Chat is a full-stack messaging application built with **Flutter**, designed to provide seamless real-time communication across mobile (Android/iOS), web, and desktop (Windows/Linux/macOS) platforms. The project demonstrates a mastery of asynchronous programming, state management, and cloud-native backend integration.

## Key Technical Implementations

### 1. Robust Firebase Ecosystem Integration
The application leverages the full suite of Firebase tools to handle backend logic without maintaining a dedicated server:
*   **Authentication:** Implemented secure email/password sign-up and login flows using `FirebaseAuth`. The app manages authentication state persistence using stream listeners to redirect users dynamically.
*   **Cloud Firestore (NoSQL):** Utilizes Firestore for the core database.
    *   **Real-time Updates:** Implemented `StreamBuilder` to listen to the `chat` collection, ensuring messages appear instantly on all connected devices without manual refreshing.
    *   **Data Modeling:** Structured data models for `User` and `Message` to map NoSQL documents to Dart objects efficiently.
*   **Firebase Storage:** Handles the upload and retrieval of user profile avatars, storing them in a structured bucket hierarchy (`user_images/avatar/`).

### 2. API & Third-Party Integration
Beyond Firebase, the application demonstrates the ability to integrate external RESTful APIs and SDKs:
*   **Cloudinary Integration:** Integrated the `cloudinary_api` to handle media assets. This demonstrates flexibility in choosing storage providers and working with HTTP requests/responses for image optimization and hosting.
*   **Image Picker:** Utilizes device-native camera and gallery APIs via the `image_picker` plugin to allow users to capture and upload profile photos.

### 3. Architecture & UI Engineering
*   **Modular Package Design:** To ensure code reusability and separation of concerns, UI components were extracted into a separate local package, **`bento_ui_kit`**. This includes custom widgets like `ContainerButton` and `CircleButton`.
*   **Navigation:** Implemented declarative routing using **GoRouter** to manage complex navigation stacks and deep linking between the Authentication and Home screens.
*   **Cross-Platform Support:** Configured native runners for Windows, Linux, and Web, ensuring the UI adapts to different screen sizes and input methods.

## Technologies Used
*   **Frontend:** Flutter (Dart)
*   **Backend:** Firebase (Auth, Firestore, Storage)
*   **APIs:** Cloudinary
*   **State Management:** Streams & FutureBuilders
*   **Navigation:** GoRouter

## Future Iterations
The project is actively evolving with planned features to enhance social interaction and utility:

*   **Codebase Refactoring & Architecture:** Adopting a more robust architectural pattern (e.g., Clean Architecture or MVVM) to improve scalability and maintainability.
*   **Comprehensive Testing:** Implementing a full suite of tests including Unit Tests, Widget Tests, and Integration Tests to ensure reliability.
*   **CI/CD Pipeline:** Setting up Continuous Integration and Deployment workflows (e.g., GitHub Actions) to automate testing and build processes.
*   **Friend System:** Implementation of a friend request and acceptance flow to allow private 1-on-1 messaging and contact management.
*   **Rich Media Sharing:** Expanding the chat capability to support sharing images, videos, and audio messages directly within the chat stream.
*   **AI Integration:** Integrating LLMs (Large Language Models) to provide intelligent features such as:
    *   **Chat Summarization:** Automatically generating summaries of long conversation threads (similar to features seen in modern social platforms).
    *   **Smart Replies:** Context-aware suggested responses.
