![Flutter](https://img.shields.io/badge/Flutter-3.24.1-blue.svg)
![Dart](https://img.shields.io/badge/Dart-3.5.1-blue.svg)

# ChatGPT Clone

An exact replica of the official ChatGPT mobile app built with Flutter. Includes:

✅ Exact pixel-perfect UI  
✅ Full support for conversational chat streaming  
✅ Image input support  
✅ Typing effects and animations  
✅ Custom proxy server to securely handle OpenAI requests
✅ Stores previous chats in MongoDB

---

### 🔗 Backend Available At  
[https://github.com/Shashwat-111/chatgpt-proxy-server](https://github.com/Shashwat-111/chatgpt-proxy-server)

---

### 🔗 Demo Video for IOS
https://drive.google.com/file/d/1V4TVh8HEh_AHx09QhxXu7PwqlNPwJNtW/view?usp=sharing

### 🔗 Demo Video for Android
https://drive.google.com/file/d/1CKJd97Z7vZq-tO4EZ8Rs31wUwkj2OGRE/view?usp=sharing

---

## Tech Stack & Project Details

- **Mobile App:** Flutter  
- **Proxy Server:** Node.js  
- **Image Handling:** Cloudinary  
- **AI:** OpenAI Chat Completion API  
- **Database:** MongoDB  
- **State Management:** None – manually handled due to simplicity

---

## Packages Used

- [`http`](https://pub.dev/packages/http) – for REST API requests  
- [`web_socket_channel`](https://pub.dev/packages/web_socket_channel) – for real-time conversational chat (`^3.0.3`)  

---

## How to Install / Run

### Flutter App
1. Clone this repo  
2. Run `flutter pub get`  
3. Start the app using `flutter run`

### Node.js Backend
1. Clone the [proxy server repo](https://github.com/Shashwat-111/chatgpt-proxy-server)  
2. Run `npm install`  
3. Create a `.env` file in the root directory with the following values:

    ```env
    OPENAI_API_KEY=
    MONGO_URI=
    CLOUDINARY_NAME=
    CLOUDINARY_API_KEY=
    CLOUDINARY_API_SECRET=
    PORT=3000
    ```

4. Start server with `node index.js`

---
