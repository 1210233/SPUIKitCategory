#!/bin/bash

tag_num=$1
last_tag=""
privateSpecName='privateSpecs'


tags=(`git tag`)

echo '=================> UPDATE START >>>'

if [ ${#tags[@]} == 0 ]
then
    echo 'git has no tags.'
    git tag -m "$tag_num" $tag_num
    git push origin $tag_num
    echo "git has create the new tag $tag_num."
else
    if echo "${tags[@]}" | grep -w $tag_num &>/dev/null; then
        echo "tag $tag_num exists."
    else
        git tag -m "$tag_num" $tag_num
        git push origin $tag_num
        
        last_tag=${tags[@]: -1}
        
        echo "git has create the new tag $tag_num, and last tag is $last_tag."
    fi
fi


for file in *.podspec
do
    if [ "$last_tag" != "" ]
    then
        echo "perform replace spec version in podspec file with the code,"
        echo "sed -i '.bak' 's/$last_tag/$tag_num/g' $file"
        sed -i ".bak" "s/$last_tag/$tag_num/g" $file
    fi



    # Pod spec lint start
    echo "now excuting 'pod spec lint --allow-warnings'..."
    rr=$(pod spec lint --allow-warnings)

    success_flag="$file passed validation"

    if [[ $rr =~ $success_flag ]]
    then
        echo "pod spec lint success."
        
        
        # Pod repo push start.
        echo "now excuting 'pod repo push $privateSpecName $file --allow-warnings'..."
        rr=$(pod repo push privateSpecs $file --allow-warnings)

        if [[ $rr =~ "Adding the spec to the " &&  $rr =~ "Pushing the " ]]
        then
            echo "pod push spec to '$privateSpecName' success."
            
#            echo "now excuting 'pod repo update $privateSpecName'..."
#            pod repo update $privateSpecName
            echo '>>>>>>>>>>>>>>>>=== UPDATE END ='
        else
            echo $rr
#            echo "pod push spec to '$privateSpecName' faild."
        fi
        # Pod repo push end.
        
        
    else
        echo $rr
    fi
    # Pod spec lint end

##    for repo in `pod repo list | grep -Ev '^$|^-'`
##    do
##    done
done
