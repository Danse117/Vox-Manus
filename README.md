# Vox Manus 🤟
---
> ASL Recognition App built with YOLOv9 and Flutter 

---

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
```
vox_manus/
├── lib/ # Flutter source code
│ ├── views/ # UI screens
│ ├── services/ # Business logic and services
│ ├── components/ # Reusable widgets
│ └── main.dart # Entry point
│
├── assets/ # Static assets
│ ├── images/
│ └── fonts/
│
├── models/ # Trained models (.tflite)
│  ├── First_Train/
│  └── Second_Train/
│
├── test/ # Test files
├── android/ # Android-specific code
├── ios/ # iOS-specific code
├── web/ # Web-specific code
│
├── pubspec.yaml # Flutter dependencies
├── README.md # Project documentation
└── .gitignore # Git ignore file
```

---

## 📋 Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install) (3.0 or higher)
- [Android Studio](https://developer.android.com/studio) with Android SDK
- [Git](https://git-scm.com/downloads)
- [Python](https://www.python.org/downloads/) (3.8 or higher)
- [pip](https://pip.pypa.io/en/stable/installation/) (for Python packages)

---

## 📋 ASL YOLOv9 Model Benchmarks

***First Train With 20 Epochs***
<img src="models/First_Train/Benchmarks/first_train_confusion_matrix.png" height=400>
<img src="models\First_Train\Benchmarks\first_train_loss_graphs.png" height=400>

***Second Training With 50 Epochs***
<img src="models/Second_Train/Benchmarks/second_train_confusion_matrix.png" height=400> 
<img src="models\Second_Train\Benchmarks\second_train_loss_graphs.png" height=400>

---
## 📚 Documentation
- [Ultralytics Documentation](https://docs.ultralytics.com/)
- [YOLOv9 Documentation](https://github.com/WongKinYiu/yolov9)
- [Ultralytics YOLOv9 Documentation](https://docs.ultralytics.com/models/yolov9/)
- [ASL Alphabet Dataset](https://public.roboflow.com/object-detection/american-sign-language-letters/1/download/yolov9)
- [Google ML Kit Image Labeling](https://pub.dev/packages/google_mlkit_image_labeling)
- [Google ML Kit Object Detection](https://pub.dev/packages/google_mlkit_object_detection)

**Tutorial's Referenced**:
- [How to Train Ultralytics YOLOv8 Models on Your Custom Dataset in Google Colab | Episode 3](https://www.youtube.com/watch?v=LNwODJXcvt4)
- [Flutter Basic Training - 12 Minute Bootcamp](https://www.youtube.com/watch?v=1xipg02Wu8s&t=92s)
- [Flutter Authentication Tutorials by Mitch Koko](https://www.youtube.com/watch?v=Dh-cTQJgM-Q&list=PLlvRDpXh1Se4Ceivpg8KrGvzb8BL9BHwo)
---

## 🏃‍♀️‍➡️ TODO
- [ ] Train models of varying datasets
- [ ] Intergrate custom model (First_Train, Second_Train)
- [ ] Consider using Firebase to save/store trained models
- [ ] Save user itranslations in Firebase