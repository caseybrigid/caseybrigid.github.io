#!/bin/bash
checkDirectries(){
    if test -d $1; then
        echo $1: "Directory exists"
    else
        echo "Couldn't find input directory, exiting..."
        echo ""
        exit
    fi

    if test -d $2; then
        echo $2: "Directory exists"
        sleep 1
    else
        echo "Couldn't find output directory, exiting..."
        echo ""
        exit
    fi
}

compressFiles(){
files=`ls $1 | grep .*.JPG`
for file in $files; do
    echo Compressing $1/$file into $2/$file 
    ffmpeg -y -i $1/$file -q:v 10 $2/$file -hide_banner -loglevel error
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
