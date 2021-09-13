from flask import Flask, render_template, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename
import numpy as np
import os
import pathlib

WEB_HOME = '/Users/kido/Desktop/project/slab2019/jawmotion_web/'
UPLOAD_DIR = 'uploads'
FFMPEG_BIN = '/opt/homebrew/bin/ffmpeg'
OPENFACE_BIN = '/home/kido/openface-himeno/build/bin/FaceLandmarkVidMulti'
ALLOWED_EXTENSIONS = set(['jpg', 'avi', 'mp4', 'webm'])

app = Flask(__name__)
app.config['UPLOAD_DIR'] = UPLOAD_DIR
app.config['WEB_HOME'] = WEB_HOME

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/")
def index():
    title = "Jaw Motion"
    return render_template('camera3.html')

@app.route("/uploadfile", methods=['GET', 'POST'])
def uploads_file():
    if request.method == 'POST':
        if 'file' not in request.files:
            flash('file is not found')
            return redirect(request.url)

        file = request.files['file']
        if file.filename == '':
            file.filename = 'testfile'

        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(UPLOAD_DIR, filename))
            file_mp4 = pathlib.Path(filename).stem + '.mp4'
            file_avi = pathlib.Path(filename).stem + '.avi'
            file_jaw = pathlib.Path(filename).stem + '_jaw.mp4'
            out = os.chdir(app.config['UPLOAD_DIR'])
            out = os.popen(FFMPEG_BIN +' -i ' + filename + ' -r 30 ' + file_mp4).read()
            out = os.popen(OPENFACE_BIN + ' -f ' + WEB_HOME + UPLOAD_DIR + '/' + file_mp4 + ' 200 20').read()
            out = os.popen(FFMPEG_BIN + ' -i processed/' + file_avi + ' -r 30 ' + file_jaw).read() 
            out = os.chdir(app.config['WEB_HOME'])
            
            return redirect(url_for('uploaded_file', filename=file_jaw))
    return '''
    <!doctype html>
    <html>
        <head>
            <meta charset="UTF-8">
            <title>file uploader</title>
        </head>
        <body>
            <h1>File Uploader</h1>
            <form method="post" enctype="multipart/form-data" action="uploadfile">
            <p><input type="file" name="file">
            <input type="submit" value="Upload">
            </form>
        </body>
    </html>
'''

@app.route('/uploads/<filename>')
def uploaded_file(filename):
    return send_from_directory(app.config['UPLOAD_DIR'], filename)

if __name__ == '__main__':
    app.debug=True
    app.threaded=True
    app.run(host='0.0.0.0', ssl_context=('cert/server.crt', 'cert/server.key'))
