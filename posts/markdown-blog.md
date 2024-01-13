# markdown blog

This website is made with the easiest way to freely host a blog I could think of - it took me maybe 20 minutes to set up. It's a github pages site, rendering from the /docs folder of a repo containing all of the post markdown folder and a single bash file to build/deploy the site. Attaching the bash script below in case someone wants to use it. First create the following folder structure:

docs
--CNAME
posts
--post1.md
--post2.md
--...
build.sh

Then initialize a git repo there and run build.sh:

```
cd docs
rm *.html
cd ../posts
rm index.md
touch index.md
echo "# Posts" >> index.md
echo "@todo write a slogan" >> index.md
echo "" >> index.md
for f in *.md; do
    echo "[${f%.md}](/${f%.md}.html)  " >> index.md
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
```

Then wire up github pages (it's just making a CNAME DNS record), and your blog will be live!
