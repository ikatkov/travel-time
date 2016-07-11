#!/usr/bin/env bash

./travel-time.personal.sh

# travel-time.personal.sh should looks like
# HOME_LOCATION='1+Main+Ave,+San+Jose,+CA';
# WORK_LOCATION='1+Main+St,+Mountain+View,+CA';
# KEY='xxxxxxxxxxxxx';
#

NOW=`date +%s`
TIME1=`curl -s "https://maps.googleapis.com/maps/api/directions/json?origin=$WORK_LOCATION&destination=$HOME_LOCATION&departure_time=$NOW&traffic_model=best_guess&key=$KEY" | jsawk 'return this.routes[0].legs[0].duration_in_traffic.text'`
TIME2=`curl -s "https://maps.googleapis.com/maps/api/directions/json?destination=$WORK_LOCATION&origin=$HOME_LOCATION&departure_time=$NOW&traffic_model=best_guess&key=$KEY" | jsawk 'return this.routes[0].legs[0].duration_in_traffic.text'`
echo "`date`,Office->Home,$TIME1,Home->Office,$TIME2"