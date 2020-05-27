#!/bin/bash

echo 'pulling mapqscores from' $1 to $2

awk -F '\t' '{print $15}' $1 > $2
