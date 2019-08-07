import librosa
import os
import subprocess
import numpy as np
import glob
import ffmpeg
from time import sleep

# os.system('dir C:\\ffmpeg')
# os.system('cd')
# subprocess.call('cd C:/ffmpeg', shell=True)
# subprocess.call('cd', shell=True)
out, _ = (
    ffmpeg
    .input('C:/ffmpeg/000002.mp3')
    .output('C:/ffmpeg/test.wav', acodec='pcm_u8', ar=22050)
    .run()
)
# a = ffmpeg.input('C:/ffmpeg/000002.mp3')
# os.chdir('C:/ffmpeg/')
# os.system('cd')
# # os.system('ffmpeg -i 000002.mp3 -acodec pcm_u8 -ar 22050 test.wav')
# subprocess.call(['ffmpeg', '-i', '000002.mp3', '-acodec', 'pcm_u8', '-ar', '22050', 'test.wav'])
# sleep(5)
# os.chdir('C:/Workspace/Python/pr_rec')
# os.system('ffmpeg -h')

# def extract_features(basedir, extension='.mp3'):
#     features = []
#     files = os.listdir(basedir)
#     files = glob.glob(os.path.join('C:\\ffmpeg', files[2]))
#     print(files[0])
#     y, sr = librosa.load(files[0])
#
#     mel_spec = librosa.feature.melspectrogram(y, sr=sr, n_mels=128, hop_length=1024, n_fft=2048)
#
#     log_mel_spec = librosa.amplitude_to_db(mel_spec, ref=np.max)
#
#     log_mel_spec = np.resize(log_mel_spec, (128, 644))
#     features.append(log_mel_spec.flatten())
#
#     features = np.asarray(features).reshape(len(features), 82432)
#
#     print(features)
#     return features
#
#
#
# dataPath = 'C:/ffmpeg'
# predictiData = extract_features(dataPath)