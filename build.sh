#/bin/sh

#param eg. sh build.sh 1.0.0 1.0.1 "I can do anything!"

if [[ $1  &&  $2 ]]
then

echo "valid tag count"

old_tag_name=$1

new_tag_name=$2

else

echo "invalid tag count"

exit

fi

if [ "$3" ]
then

summary="$3"

else

summary='update something'

fi

#param change podspec version

spec_filename='HJArchitecture.podspec'

sed -i '' "s/$old_tag_name/$new_tag_name/g" $spec_filename

#param push code

echo "start push new code..."

#parm ignorecase false

git config core.ignorecase false

git add -A

git commit -am "$summary"

git push

echo "finish push new code"

echo "start git new tag..."

git tag $new_tag_name

git push origin $new_tag_name

sudo xcode-select -switch /Applications/Xcode.app/

echo "finish push new tag"

#pod lib lint

echo "start push $spec_filename ..."

pod repo push HJSpecs $spec_filename

