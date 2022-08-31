# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file
"""

import mechanize

br = mechanize.Browser()
br.set_handle_robots( False )
br.set_handle_refresh(False)
br.addheaders = [('User-agent', 'Firefox')]

br.open('https://globaldjmix.com/livedj/above---beyond')
episode_number = 442
episode_string = "abgt-" + str(episode_number)

for l in br.links():
    if episode_string in l.url and 'autoplay' not in l.url:
        br.follow_link(l) #follow link corresponding to episode
        break

for l in br.links():
    if "box.download" in l.text:
        br.follow_link(l)
        break
    elif "fex.download" in l.text:
        br.follow_link(l)
        break
        
for l in br.links():
    print (l.url)

#print(br.links()[0].url) #only one link on the final download page
                                