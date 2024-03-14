#!/bin/bash

if [ -n "$1" ]; then
  existingDir=$1
fi

if [ -n "$2" ]; then
  newDir=$2
fi

if [ -n "$3" ]; then
  noDiff="$3"
fi

if [ -z "$existingDir" ]; then
  exit
fi

if [ -z "$newDir" ]; then
  exit
fi

for existingFile in "$existingDir"/*; do
  existingFilename=`basename "$existingFile"`
  newFile="$newDir/$existingFilename"

  theDiff=`diff --color=always "$existingFile" "$newFile"`

  if [ -n "$theDiff" ]; then
    if [ "$noDiff" != "true" ]; then
      printf "\n### "
    else
      printf "\n"
    fi

    printf "$existingFilename"

    if [ "$noDiff" != "true" ]; then
      printf "\n$theDiff\n"
    fi
  fi
done

if [ "$noDiff" == "true" ]; then
  printf "\n"
fi
