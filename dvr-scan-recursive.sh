#!/bin/bash
f=$(find . -type f \( -iname "*.mp4" -o -iname "*.avi" ! -iname "motion_*" \))

for file in $f
do

    INPUTFILE=${file}
    OUTPUTDIR=$(dirname ${file})/result/
    OUTPUTFILE=$OUTPUTDIR"motion_"$(basename ${file})".avi"
    COMPLETEFILE=$OUTPUTFILE".complete"
    mkdir -p $OUTPUTDIR
    if [ -e $COMPLETEFILE ]
    then
        echo "Пропустил "$INPUTFILE
    else
        rm -f $OUTPUTFILE
        rm -f $COMPLETEFILE
        echo "Start "$INPUTFILE
        exec 5>&1
        export COMPLETEFILEVALUE=$(dvr-scan -i $INPUTFILE -o $OUTPUTFILE ${ADD_ARGS:-}|tee >(cat - >&5))
        echo $COMPLETEFILEVALUE > $COMPLETEFILE
    fi
done 
