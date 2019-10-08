import argparse
import os
import youtube_dl as yd
from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.action_chains import ActionChains
import time
import subprocess

storedir = os.path.dirname(os.path.abspath(__file__))
driver = webdriver.Chrome(storedir+'/chromedriver')

def main():
    parser = argparse.ArgumentParser(description='youtube crawler')

    parser.add_argument('--search', '-s', type=str, default='240p video',
                        help='search word')
    parser.add_argument('--quality', '-q', type=str, default='720',
                        help='video resolution')
    parser.add_argument('--directory', '-d', type=str, default=storedir + '/Video',
                        help='download directory path')
    # parser.add_argument('--page', '-p', type=int, default=25,
    #                     help='page number')
    args = parser.parse_args()

    download_vid(args.directory, args.search, args.quality)

def download_vid(downdir, search, quality):
    ytdl_options = {
        # 'format': 'bestvideo[ext=mp4]+bestvideo[height>=720]+bestvideo[acode=None]/best[ext=mp4]+best[height>=720]/best',
        # 'format': '137',
        # 'formats':[{
        #     'ext': 'mp4',
        #     'acodec': 'None'
        # }],
        # 'acodec': 'skip',
        # 'ignoreerrors': 'True',
        'outtmpl': downdir + '/%(title)s.%(ext)s'
        # 'postprocessors': [{
        #     'key': 'FFmpegVideoConvertor',
        #     'preferedformat': 'mp4',
        #     'frame_rate': '30'
        # }]
    }

    word = search.replace(' ', '+')
    url = 'https://www.youtube.com/results?search_query=' + word

    driver.get(url)
    driver.implicitly_wait(2)

    index = 0
    video_num = 0

    while (True):
        page = BeautifulSoup(driver.page_source, 'lxml')
        lists = page.find_all('ytd-video-renderer')

        if (len(lists) == 0 or len(lists) == index):
            break

        for i in range(index, len(lists)):
            try:
                temp_url = lists[i].find('a', attrs={'id': 'thumbnail'}).attrs['href']
                time.sleep(5)
                vid = yd.YoutubeDL(ytdl_options)
                video_url = 'https://www.youtube.com'+ temp_url
                # info = vid.extract_info(video_url, download=True)
                info = vid.extract_info('https://www.youtube.com/watch?v=IRbdp6e_73g', download=True)
                # print('check', info.get('height'))
                # print("check:", vid.format_resolution(info))
                video_num += 1
                print('Number of Downloaded Video:', video_num)
                file_name = vid.prepare_filename(info)
                # result = subprocess.Popen(['ffmpeg', '-y', '-i', downdir+'/'+file_name,
                #                            downdir+'/'+file_name+'.mp4'])
                # result = subprocess.Popen(['youtube-dl', '-F', 'https://www.youtube.com/watch?v=IRbdp6e_73g'], stdout=subprocess.PIPE)
                # out, err = result.communicate()
                # exitcode = result.returncode
                # if (exitcode == 0):
                #     print('success')
                # else:
                #     print('fail')
                break
            except Exception as e:
                print(e)
                continue
        break
        index = len(lists)
        ActionChains(driver).key_down(Keys.END).key_up(Keys.END).perform()
        time.sleep(5)

if __name__=='__main__':
    main()