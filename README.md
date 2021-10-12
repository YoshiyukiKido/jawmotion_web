# JawMotion Capture Application Web Frontend
A JawMotion Capture Application based on OpenFace has been developed.
It is a web frontend of the JawMotion Capture Application. It requires Flask, which is a python based web framework. 
The main functionalities of this application is a video recording and a web based analysis for jawmotion.

## Installation
First, please make clone repository.
```
git clone https://github.com/YoshiyukiKido/jawmotion_web.git
```
Then, you shoud install requirement libraries and applications, such as [flask](https://flask.palletsprojects.com/en/2.0.x/), [ffmpeg](https://www.ffmpeg.org/) and [OpenFace](https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download).
And, apply our patch files to OpenFace source for jaw motion capture functionality.

### ~~macOS~~
```
pip install flask flask-login flask-sqlalchemy
brew install ffmpeg
```

### Ubuntu 20.04
```
pip install flask flask-login flask-sqlalchemy
sudo apt install ffmpeg
git clone https://github.com/TadasBaltrusaitis/OpenFace.git
cd jawmotion_web
patch -u ../OpenFace/lib/local/Utilities/include/Visualizer.h < Visualizer_h_diff.txt
patch -u ../OpenFace/exe/FaceLandmarkVidMulti/FaceLandmarkVidMulti.cpp < FaceLandmarkVidMult_cpp_diff.txt
cd ../OpenFace
./install.sh    # The install script stops in the middle, but it's okay.
...
mkdir -p opencv-4.1.0/build
cd opencv-4.1.0/build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D WITH_CUDA=OFF -D BUILD_SHARED_LIBS=OFF ..
make -j4
cd ../..
wget http://dlib.net/files/dlib-19.13.tar.bz2
tar xf dblib-19.13.tar.bz2
mkdir -p dlib-19.13/build
cd dlib-19.13/build
cmake ..
cmake --build . --config Release
sudo make install
sudo ldconfig
cd ../..
mkdir build
cd build
cmake -D CMAKE_CXX_COMPILER=g++-8 -D CMAKE_C_COMPILER=gcc-8 -D CMAKE_BUILD_TYPE=RELEASE ..
make
```

After that, you shoud take the model data from [https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download](https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download).
```
cen_patches_0.25_of.dat
cen_patches_0.35_of.dat
cen_patches_0.50_of.dat
cen_patches_1.00_of.dat
```
And put these files to OpenFace model directory (OpenFace/build/bin/model/patch_experts).

## Configuration
Before starting Flask, please modifiy environmental variables in jawmotion_app.py.
```
WEB_HOME = '/home/kido/jawmotion_web/' # home dir of this web application
UPLOAD_DIR = 'uploads'  # upload moview dir
FFMPEG_BIN = '/usr/bin/ffmpeg'  # ffmpeg command file
OPENFACE_BIN = '/home/kido/OpenFace/build/bin/FaceLandmarkVidMulti'
```
And, make a server certification and keyfile for https. Because, this application use a web camera functionality via a client browser. It's need to do via https.
```
sudo apt install openssl
mkdir cert
cd cert
openssl genrsa 2048 > server.key
openssl req -new -key server.key > server.csr
openssl x509 -days 3650 -req -signkey server.key < server.csr > server.crt
```

## Start Flask
```
cd INSTALL DIR
python jawmotion_app.py
```
Then, you can look at https://localhost:5000 via a web browser.
