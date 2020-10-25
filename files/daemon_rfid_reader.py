#!/usr/bin/env python3

import logging
import os
import subprocess
import time
import re
import requests
import json
from Reader import Reader


## Logger definition
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
ch = logging.StreamHandler()
ch.setLevel(logging.INFO)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
logger.addHandler(ch)


## Reader Class
reader = Reader()

## Get absolute path of this script
dir_path = os.path.dirname(os.path.realpath(__file__))
file_path = os.path.dirname(__file__)
logger.info('Working directory: {dir_path}'.format(dir_path=dir_path))

## Change to script dir
if file_path != "":
    os.chdir(file_path)

## Empty array for cards
cards = []
## Open file with allowed rfid card ID's
#with open(os.path.join(dir_path, 'rfid-cards.txt'), 'r') as file:
#    content = file.readlines()

 #   for line in content:
        ## Ensure that the last character "\n" is removed 
        #cids = line[:-1]
 #       cards.append(cids)

with open(os.path.join(dir_path, 'rfid-cards.txt'), 'r') as file:
    allowedcards = json.load(file)
    #content= content.replace('\n','')
    logger.info('Follwing cards will be accepted:')
    print(json.dumps(allowedcards, indent=4, sort_keys=True))
    file.close()
         
## Printing loaded cards
#logger.info('Loaded follwing cars {cards}'.format(cards=cards))
## Vvars for ensuring delay between same-card-swipes
previous_id = ""
previous_time = time.time()
same_id_delay = 2

while True:
    # If Issue exists try instead:
    # cardid = reader.readCard()
    cardid = reader.reader.readCard()
    try:
        # start the player script and pass on the cardid (but only if new card or otherwise
        # "same_id_delay" seconds have passed)
        if cardid is not None:
            logger.info('Check access for Card: {cardid}'.format(cardid=cardid))
            for key in allowedcards:
                if cardid in allowedcards[key] and (time.time() - previous_time) >= float(same_id_delay):
                    logger.info('{name} registerd with card {card}'.format(name=key,card=allowedcards[key]))                    #subprocess.call([dir_path + '/rfid_trigger_play.sh --cardid=' + cardid], shell=True)
                   # curl -X POST --header "Content-Type: text/plain" --header "Accept: application/json" -d "ON" "http://localhost:8080/rest/items/Relay1"
                    resp = requests.post("http://localhost:8080/rest/items/Relay1", "ON")
                    print(resp.text)

                    previous_time = time.time()
                elif (time.time() - previous_time) <= float(same_id_delay):
                    logger.debug('Ignoring Card id {cardid} due to same-card-delay, or i delay: {same_id_delay}'.format(
                        cardid=cardid,
                        same_id_delay=same_id_delay
                        ))
    except OSError as e:
      logger.error('Execution failed: {e}'.format(e=e))
