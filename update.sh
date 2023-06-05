#!/bin/sh

set -e

VERSION=$1

if [ -z $1 ]
then
    echo "Usage: update.sh <version>"
    echo "\nExample: update.sh 1.8.0"
    exit 1
fi

FILENAME="${VERSION}.tar.gz"
URL="https://github.com/bbc/audiowaveform/archive/$FILENAME"

if [ -e $FILENAME ]
then
    echo "Found $FILENAME"
else
    echo "Fetching $URL"
    wget $URL -O $FILENAME
fi

SHASUM=`sha256sum $FILENAME | grep -Eo '[0-9a-f]{64}'`

echo "sha256: $SHASUM"

FORMULA_FILENAME=audiowaveform.rb

sed -i "s|url \".*\"|url \"$URL\"|" $FORMULA_FILENAME
sed -i "s|sha256 \".*\"|sha256 \"${SHASUM}\"|" $FORMULA_FILENAME

echo "Updated $FORMULA_FILENAME"
