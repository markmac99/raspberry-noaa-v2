import sys
import os
from mastodon import Mastodon


def postit(msg, imgs):
    tokfile = os.path.expanduser('~/.ssh/mastodon_token.secret')
    mstdn = Mastodon(access_token=tokfile, api_base_url='https://botsin.space/')
    mediaids = []
    if imgs is not None:
        for img in imgs:
            mediaids.append(mstdn.media_post(img))
        mstdn.status_post(msg, media_ids = mediaids)
    else:
        mstdn.status_post(msg)

if __name__ == '__main__':
    msg = sys.argv[1]
    imgs = []
    if len(sys.argv) > 1:
        for r in range (2, len(sys.argv)):
            imgs.append(sys.argv[r])
    #print(msg, imgs)
    postit(msg, imgs)

