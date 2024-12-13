# Vox Manus 🤟
---
> ASL Recognition App built with YOLOv9 and Flutter

## Overview
Vox Manus is an American Sign Language (ASL) recognition application that uses state-of-the-art YOLOv9 object detection and Flutter for cross-platform deployment.

## 🛠️ Tech Stack
- **Machine Learning**: YOLOv9, TensorFlow Lite
- **Frontend**: Flutter, Dart
- **Backend**: Firebase
- **Development Tools**: 
  - Android Studio
  - VS Code
  - Google Colab (for model training)
---
## 📁 Project Structure
vox_manus/
├── lib/ # Flutter source code
│ ├── models/ # Data models
│ ├── screens/ # UI screens
│ ├── services/ # Business logic and services
│ ├── widgets/ # Reusable widgets
│ └── main.dart # Entry point
│
├── ml/ # Machine Learning components
│ ├── models/ # Trained models (.tflite)
│ ├── training/ # Training scripts and notebooks
│ └── utils/ # ML utilities
│
├── assets/ # Static assets
│ ├── images/
│ └── fonts/
│
├── test/ # Test files
├── android/ # Android-specific code
├── ios/ # iOS-specific code
├── web/ # Web-specific code
│
├── pubspec.yaml # Flutter dependencies
├── README.md # Project documentation
└── .gitignore # Git ignore file

---

## 📋 Prerequisites
Before you begin, ensure you have the following installed:
- [Flutter](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- [Android Studio](https://developer.android.com/studio) with Android SDK
- [Git](https://git-scm.com/downloads)
- [Python](https://www.python.org/downloads/) (3.8 or higher)
- [pip](https://pip.pypa.io/en/stable/installation/) (for Python packages)

---

## 📚 Documentation

[Ultralytics Documentation](https://docs.ultralytics.com/)

[YOLOv9 Documentation](https://github.com/WongKinYiu/yolov9)

[Ultralytics YOLOv9 Documentation](https://docs.ultralytics.com/models/yolov9/)
[ASL Alphabet Dataset](https://public.roboflow.com/object-detection/american-sign-language-letters/1/download/yolov9)

**Tutorial's Referenced**:
- [How to Train Ultralytics YOLOv8 Models on Your Custom Dataset in Google Colab | Episode 3](https://www.youtube.com/watch?v=LNwODJXcvt4)
- [Flutter Basic Training - 12 Minute Bootcamp](https://www.youtube.com/watch?v=1xipg02Wu8s&t=92s)

---

## 🏃‍♀️‍➡️ TODO
- [ ] Make home look nicer
- [ ] Change camera to take pictures instead of video and intergrate with YOLOv9
- [ ] Train models of varying datasets
- [ ] Save user information/translations in Firebase


