#!/usr/bin/env bash

# TODO rename to build-unix ?

# $1 is a jq repository path
# $2 is a output directory path

# NOTE: not executed yet.

function usage() {
  cat <<EOF
Usage: $0 jq-path out-path

Example:
  $0 /app/jq /app/out
EOF
}

JQ_PATH=$1
if [[ $JQ_PATH == "" ]] ; then
  usage
  exit 1
fi

OUT=$2
if [[ $OUT == "" ]] ; then
  usage
  exit 1
fi

cd $JQ_PATH

echo Build from commit $(git describe --tags)

autoreconf -fi

./configure CFLAGS=-fPIC --disable-maintainer-mode \
    --enable-all-static \
    --disable-shared \
    --disable-docs \
    --disable-tls \
    --disable-valgrind \
    --with-oniguruma=builtin --prefix=$OUT

make -j2

make install-libLTLIBRARIES install-includeHEADERS

cp modules/oniguruma/src/.libs/libonig.* $OUT/lib

# binary ?
make install

echo "JQ version:"
$OUT/bin/jq --version

echo "Quick jq binary test:"
echo '{"Key0":"asd", "NUMS":[1, 2, 3, 4, 5.123123123e+12]}' | $OUT/bin/jq '.'


mkdir $OUT/libjq
mv $OUT/lib $OUT/include $OUT/libjq

find . -type f -exec sha256sum {} \; > $OUT/all.sha
cd $OUT/libjq
find . -type f -exec sha256sum {} \; > $OUT/libjq.sha
echo "all.sha"
cat $OUT/all.sha
echo "libjq.sha"
cat $OUT/libjq.sha

echo "===================================="
echo "   files in $OUT:"
echo "===================================="
find $OUT -exec ls -lad {} \;
echo "===================================="

#echo "Use these flags with go build:"
#echo "CGO_CFLAGS=-I${out}/include"
#echo "CGO_LDFLAGS=-L${out}/lib"

