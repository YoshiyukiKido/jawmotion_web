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

### ~~macOS~~
```
pip install flask
brew install ffmpeg
```

### ubuntu 
```
pip install flask
sudo apt install ffmpeg
git clone https://github.com/TadasBaltrusaitis/OpenFace.git
cd jawmotion_web
patch -u ../OpenFace/lib/local/Utilities/include/Visualizer.h < Visualizer_h_diff.txt
patch -u ../OpenFace/exe/FaceLandmarkVidMulti/FaceLandmarkVidMulti.cpp < .FaceLandmarkVidMult_cpp_diff.txt
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

After that, you shoud take the model data from https://github.com/TadasBaltrusaitis/OpenFace/wiki/Model-download.
```
cen_patches_0.25_of.dat
cen_patches_0.35_of.dat
cen_patches_0.50_of.dat
cen_patches_1.00_of.dat
```
And put these files to OpenFace model directory (OpenFace/build/bin/model/patch_experts).

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
