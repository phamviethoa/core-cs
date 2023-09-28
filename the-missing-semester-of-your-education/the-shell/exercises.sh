#!/bin/zsh

# create a new directory called missing
mkdir -p missing

# create a new file called semester in missing directory
touch ./missing/semester

# write the content to the semester file
echo '#!/bin/sh' > ./missing/semester
echo 'curl --head --silent https://missing.csail.mit.edu' >> ./missing/semester

# provde the execution permission for the file owner
chmod u+x ./missing/semester

# execute the semester file
./missing/semester

# write the last modified date of the semester file into a file called
# last-modifed.txt
ls -l missing | cut -d ' ' -f 6,7,8 > last-modified.txt
cat last-modified.txt

