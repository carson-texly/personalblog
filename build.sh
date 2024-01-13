#!/bin/bash
cd docs
rm *
cd ../posts
for f in *.md; do
    pandoc --standalone $f > ../docs/${f%.md}.html
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

