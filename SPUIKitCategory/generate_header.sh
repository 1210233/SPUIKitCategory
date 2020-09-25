#! /bin/sh

pathname=`pwd`
pathname=$(basename $pathname)
header=$pathname'.h'

function e(){
#echo $1
    for file in `ls $1`
    do
        if [ -d $1$file ]
        then
            e $1$file
        else
            if [[ $file == *.h ]]
            then
                echo "#import \"$file\"" >> $header
            fi
        fi
    done
}


sed -i '' '1,$d' $header
d=`date +%Y/%m/%d`
yyyy=$(date '+%Y年')
echo "//" >> $header
echo "//  $header" >> $header
echo "//  $pathname" >> $header
echo "//" >> $header
echo "//  Updated by LSP on $d." >> $header
echo "//  Copyright (c) $yyyy LSP. All rights reserved." >> $header
echo "//" >> $header
echo "" >> $header
echo "" >> $header
echo "#ifdef __OBJC__" >> $header
echo "" >> $header

for file in `ls`
do
    if [ -d $1$file ]
    then
    
        echo "s.subspec '$file' do |ss|"
        echo "    ss.source_files = '$pathname/$file/*.{h,m}'"
        echo "    ss.public_header_files = '$pathname/$file/*.h'"
        echo "end"
        echo ""
        
        e $1$file
    fi
done

echo "" >> $header
echo "" >> $header
echo "#endif" >> $header
echo "" >> $header
