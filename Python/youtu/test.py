# import youtube_dl
# import time
# import subprocess
# import os
#
# options = {
#     'outtmpl': 'test',
#     'postprocessors': [{
#         'key': 'FFmpegVideoConvertor',
#         'preferedformat': 'mp4'
#     }]
# }
# dir = os.path.dirname(os.path.abspath(__file__))
#
# timer = time.time()
#
# ydl = youtube_dl.YoutubeDL(options)
#
# ydl.download(['https://www.youtube.com/watch?v=wDgQdr8ZkTw'])
#
# # result = subprocess.Popen(['ffmpeg', '-y', '-i', dir+'/test.webm', dir+'/test.mp4'])
# # out, err = result.communicate()
# # exitcode = result.returncode
# # if (exitcode == 0):
# #     print('success')
#
# print('time:',time.time() - timer)
# from pytube import YouTube
# yt= YouTube('https://www.youtube.com/watch?v=Nvk9wTNSrlE')
# yt.streams.filter(progressive=True, file_extension='mp4').order_by('resolution').desc().first().download()

video_quality = {'240p':0, '360p':1, '480p':2, '720p':3, '1080p':4}

q = '720p'

for resol, num in video_quality.items():
    if (num >= video_quality[q]):
        print(resol)