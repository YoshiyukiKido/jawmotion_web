# JawMotion Capture Application Web Frontend
We have been developed a Jawmotion Capture Application based on OpenFace. This is a web frontend of JawMotion Capture application.
It requires flask that is python based web framework.
Main functionalities of this application is a uploading caputre movie and a openface based analysis for jaw motion.

## Installation
First, please make clone repository.
```
git clone https://github.com/YoshiyukiKido/jawmotion_web.git
```
Then, you shoud install requirement libraries and applications.

# macOS
```
pip install flask
brew install ffmpeg
```

# ubuntu
```
pip install flask
sudo apt install ffmpeg
```

## Start Flask
```
cd INSTALL DIR
python jawmotion_app.py
```
Then, you can look at https://localhost:5000 via a web browser.
