#! /bin/bash
before='/home/$USER/Desktop/folder/file_with_links.txt'
converted='/home/$USER/Desktop/folder/url_converted.txt'
downloaded_path='/home/$USER/folder/zalupen/downloaded/'
#
echo "All links must start with https:// or http://"
# Começo do loop
while read url; do
  if [[ -z $url ]]
   then continue
  else
   if [[ $url == https://cdn* ]];then
     url=$(echo $url | sed "s/ /%20/g")
     echo $url >> $converted
     echo "$url already converted"
   else
    url=$(curl -s "$url" | grep -E "https://cdn|http://cdn" | tail -n 1 | awk -F[\",] '{print $2}')
    if [[ -z $url ]];then
      continue
    else
      url=$(echo $url | sed "s/ /%20/g")
      echo $url >> $converted
      echo "$url converted"
    fi
   fi
  fi
done < $before
while read url; do
    wget $url --tries=1 -P $downloaded_path
done < $converted
