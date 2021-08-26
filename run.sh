# node.js version to download
# examples:
# VERSION="v16.7.0"
VERSION="v16.7.0"

# source to download from
# examples:
# MIRROR="https://nodejs.org/download/release"
# MIRROR="https://unofficial-builds.nodejs.org/download/release"
MIRROR="https://unofficial-builds.nodejs.org/download/release"

# file to download (without extension, must be linux x64)
# examples:
# FILE="node-$VERSION-linux-x64"
# FILE="node-$VERSION-linux-x64-pointer-compression"
FILE="node-$VERSION-linux-x64-pointer-compression"


##### Begin script
find -maxdepth 1 -type d -regex .*node-.*-linux-x64.* -not -regex .*${FILE} -exec rm -r {} \;
PATH=./$FILE/bin:${PATH}
if [ -d "./$FILE" ] 
then
	./${FILE}/bin/npm install
    ./${FILE}/bin/node .
	if [ $? -eq 139 ]
	then
		rm -r ${FILE}
		echo "Environment changed"
		echo "Redownloading $FILE"
		wget -O- ${MIRROR}/${VERSION}/${FILE}.tar.xz | tar -xJf- --one-top-level=./
		./${FILE}/bin/npm install
		./${FILE}/bin/node .
	fi
else
    echo "Downloading $FILE"
	wget -O- ${MIRROR}/${VERSION}/${FILE}.tar.xz | tar -xJf- --one-top-level=./
	./${FILE}/bin/npm install
	./${FILE}/bin/node .
fi