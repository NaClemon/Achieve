import argparse
import os
import youtube_dl as yd
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
import time
import subprocess

# set download directory
storedir = os.path.dirname(os.path.abspath(__file__))
# ready selenium
driver = webdriver.Chrome(storedir + '/chromedriver')
# video quality dictionary
video_quality = {'240p': 0, '360p': 1, '480p': 2, '720p': 3, '1080p': 4}


def main():
    parser = argparse.ArgumentParser(description='youtube crawler')

    # set argument
    parser.add_argument('--search', '-s', type=str, default='안무',
                        help='search word')
    parser.add_argument('--format', '-f', type=str, default='mp4',
                        help='video format')
    parser.add_argument('--quality', '-q', type=str, default='720p',
                        help='video resolution')
    parser.add_argument('--directory', '-d', type=str, default=storedir + '/Video',
                        help='download directory path')
    args = parser.parse_args()

    download_vid(args.directory, args.search, args.format, args.quality)


def download_vid(downdir, search, video_format, quality):
    # set youtube-dl option
    ytdl_options = {
        'outtmpl': downdir + '/%(title)s.%(ext)s'
    }
    quality_list = []
    # video quality option
    for vq, num in video_quality.items():
        if (num >= video_quality[quality]):
            quality_list.append(vq)

    url = 'https://www.youtube.com/results?search_query=' + search

    driver.get(url)
    driver.implicitly_wait(2)

    index = 0
    video_num = 0

    # download video
    while (True):
        page = BeautifulSoup(driver.page_source, 'lxml')
        lists = page.find_all('ytd-video-renderer')

        # no more video
        if (len(lists) == 0 or len(lists) == index):
            break

        for i in range(index, len(lists)):
            try:
                # get video url
                temp_url = lists[i].find('a', attrs={'id': 'thumbnail'}).attrs['href']
                time.sleep(5)
                video_url = 'https://www.youtube.com' + temp_url

                # to select video format code
                result = subprocess.Popen(['youtube-dl', '-F', video_url], stdout=subprocess.PIPE)
                out, err = result.communicate()

                formatlist = out.decode('utf-8').split('\n')
                find_vid = False
                # select video format code
                for q in reversed(quality_list):
                    for formatinfo in reversed(formatlist):
                        resol, format = formatinfo.find(video_format), formatinfo.find(q)
                        if (resol != -1 and format != -1):
                            ytdl_options['format'] = formatinfo.split(' ')[0]
                            find_vid = True
                            break
                    if (find_vid):
                        break

                # download video
                if ('format' in ytdl_options.keys()):
                    vid = yd.YoutubeDL(ytdl_options)
                    info = vid.extract_info(video_url, download=True)

                    video_num += 1
                    print('Number of Downloaded Video:', video_num)

                    del ytdl_options['format']

            except Exception as e:
                print('Error:', e)
                continue

        index = len(lists)
        ActionChains(driver).key_down(Keys.END).key_up(Keys.END).perform()
        time.sleep(5)

    print('=====End Downloading.=====')


if __name__ == '__main__':
    main()
