#!/bin/bash
for file in *; do
    ffmpeg -y -i $file -q:v 10 s_$file
    # ffmpeg -y -i $file -q:v 100 l_$file
    # convert -strip -interlace plane -quality 10 s_$file c_$file
done