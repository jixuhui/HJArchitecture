#/bin/sh

#eg. sh build.sh v1.0.0 v1.0.1 "I can do anything!"

if [[ $1  &&  $2 ]]
then

echo "valid tag count"

old_tag_name=$1

new_tag_name=$2

else

echo "invalid tag count"

exit

fi

#tag_reg='^(v){1}([0-9]{1}.){2}[0-9]{1}$'

#if [[ "$old_tag_name" =~ $tag_reg && "$new_tag_name" =~ $tag_reg ]]
#then
#
#echo "valid tag name"
#
#else
#
#echo "$old_tag_name or $new_tag_name invalid tag name! you need input like this,eg. 1.1.1"
#
#exit
#
#fi

if [ "$3" ]
then

summary="$3"

else

summary='update something'

fi

#change podspec version

spec_filename='HJArchitecture.podspec'

sed -i '' "s/$old_tag_name/$new_tag_name/g" $spec_filename

#push code

echo "start push new code..."

#ignorecase false

git config core.ignorecase false

git add -A

git commit -am "$summary"

git push

echo "finish push new code"

echo "start git new tag..."

git tag $new_tag_name

git push origin $new_tag_name

echo "finish push new tag"

#lib lint

pod lib lint

echo "start push $spec_filename ..."

pod repo push HJSpecs $spec_filename

