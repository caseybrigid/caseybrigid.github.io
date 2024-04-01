#!/bin/bash

# Add folder with new images with portfolio titled "new" to top level
# Replaces src/public/portfolio/img

FROM="./new"
TO="./src/public/portfolio/img"

checkDirectries(){
    if test -d $1; then
        echo $1: "Input Directory exists"
    else
        echo "Couldn't find input directory, exiting..."
        echo ""
        exit
    fi

    if test -d $2; then
        echo $2: "Output Directory exists, clearing it..."
        rm -rf $2
        mkdir  $2
        sleep 1
    else
        echo "Couldn't find output directory, exiting..."
        echo ""
        exit
    fi
}

rename(){
    cnt=1
    for fname in $1/*
    do
        mv "$fname" "$2/$cnt.jpg"
        cnt=$(( $cnt + 1 ))
    done
}

compressFiles(){
files=`ls $1 |  grep -iE ".*.(JPG|JPEG|jpg|jpeg)"`
for file in $files; do
    echo Compressing "$1/$file" into "$2/$file" 
    #ffmpeg -y -i $1/$file -q:v 10 $2/$file -hide_banner -loglevel error
    #convert $1/$file -interlace plane $2/$file
    #jpegtran -copy none -progressive -outfile "$2/$file" "$1/$file" 
    ffmpeg -y -i "$1/$file" -q:v 10 "$2/$file"
    # convert -strip -interlace plane -quality 10 s_$file c_$file
done
}

genDescription(){
    echo "Generating description.json..."
    node "src/public/portfolio/gen-v2.js"
}

echo ""
checkDirectries $FROM $TO 
echo ""
rename $FROM $FROM
compressFiles $FROM $TO
genDescription
echo ""
echo "Done!"
echo ""
