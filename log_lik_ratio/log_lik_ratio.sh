#!/bin/bash

echo 'Printing log_lik_ratio numbers to specified input file'
awk -F '\t' '{print $6}' $1 > $2
