#/bin/sh

#eg. sh build.sh 1.0.0 1.0.1 "I can do anything!"

if [ "$1" ]
then

summary="$1"

else

summary='update something'

fi

echo "start push new code..."

#ignorecase false
git config core.ignorecase false

git pull

git add -A

git commit -am "$summary"

git push origin develop

echo "finish push new code"

sudo xcode-select -switch /Applications/Xcode.app/

#lib lint
pod lib lint

echo "start push $spec_filename ..."

pod repo push HJSpecs $spec_filename

