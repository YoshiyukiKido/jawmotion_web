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

### macOS
```
pip install flask
brew install ffmpeg
```

### ubuntu
```
pip install flask
sudo apt install ffmpeg
```

## Setup and Start Flask
Before starting Flask, please modifiy environmental variables in jawmotion_app.py.
```
WEB_HOME = '/Users/kido/Desktop/project/slab2019/jawmotion_web/' # home dir of this web application
UPLOAD_DIR = 'uploads'  # upload moview dir
FFMPEG_BIN = '/opt/homebrew/bin/ffmpeg'  # ffmpeg command file
OPENFACE_BIN = '/home/kido/openface-himeno/build/bin/FaceLandmarkVidMulti'  # NOT USE (modified openface command
```


```
cd INSTALL DIR
python jawmotion_app.py
```
Then, you can look at https://localhost:5000 via a web browser.
