#!/bin/bash

fetch_if_not_found() {
    length=$#
    prefixlen=$(($length-1))
    echo $length
    echo $prefixlen
    url=${@:${length}}
    cmd=${@:1:${prefixlen}}

    filename=$( basename "$url" )
    echo "url: $url"
    echo "Filename: $filename"
    if [[ ! -f "$filename" ]]
    then
        wget "$url"
        $cmd $filename
    fi
}
fetch_if_not_found tar xzf  http://vis-www.cs.umass.edu/lfw/lfw.tgz

fetch_if_not_found bzip2 -d http://dlib.net/files/shape_predictor_68_face_landmarks.dat.bz2
