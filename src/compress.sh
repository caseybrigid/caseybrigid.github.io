#!/bin/bash
checkDirectries(){
    if test -d $1; then
        echo $1: "Input Directory exists"
    else
        echo "Couldn't find input directory, exiting..."
        echo ""
        exit
    fi

    if test -d $2; then
        echo $2: "Output Directory exists"
        sleep 1
    else
        echo "Couldn't find output directory, exiting..."
        echo ""
        exit
    fi
}

compressFiles(){
files=`ls $1 |  grep -iE ".*.(JPG|JPEG)"`
for file in $files; do
    echo Compressing $1/$file into $2/$file 
    #ffmpeg -y -i $1/$file -q:v 10 $2/$file -hide_banner -loglevel error
    #convert $1/$file -interlace plane $2/$file
    jpegtran -copy none -progressive -outfile $2/$file $1/$file 
    # ffmpeg -y -i $file -q:v 100 l_$file
    # convert -strip -interlace plane -quality 10 s_$file c_$file
done
}

echo ""
checkDirectries $1 $2
echo ""
compressFiles $1 $2
echo ""
echo "Done!"
echo ""
