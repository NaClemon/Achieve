from pytube import YouTube

yt = YouTube('https://www.youtube.com/watch?v=BuE2aexPbik')

yt.streams\
    .filter(progressive=True, file_extension='mp4')\
    .order_by('resolution')\
    .desc()\
    .first()\
    .download()
