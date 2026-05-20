#!/bin/bash

echo $1

INPUT=$1

IFS=',' read -ra ARRAY <<< "$INPUT" 
printf "%s\n" "${ARRAY[@]}"| tr '[:upper:]' '[:lower:]' | sort | uniq  
