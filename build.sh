#!/bin/bash
cd docs
rm *.html
cd ../posts
#build index.md
rm index.md
touch index.md
echo "# blog" >> index.md
echo "@todo write a slogan" >> index.md
echo "" >> index.md
for f in *.md; do
    if [ $f == "index.md" ]; then
        continue
    fi
    echo "[${f%.md}](https://blog.carson-cummins.com/${f%.md}.html)  " >> index.md
done
for f in *.md; do
    pandoc --standalone $f -V mainfont=Helvetica > ../docs/${f%.md}.html
done
cd ..
FILE="commitcount.txt"
if [ -s $FILE ]; then
    read -r number < $FILE
    ((number++))
else
    number=1
fi
git add .
git commit -m "[$number] automated build commit"
git push origin master
echo $number > $FILE
echo "okie dokie!"

