#!/usr/bin/zsh

# $() is use to get the result of the given program, for example in below line,
# the date return the current datetime
echo "Starting program at $(date)"

# $0 is the name of the program
# $# is the number we pass to the program when call the program
# $$ is the process id of the program
echo "Running program $0 with $# arguments with pid $$"

for file in "$@"; do
  grep foobar "$file" > /dev/null 2> /dev/null

  if [[ "$?" -ne 0 ]]; then
    echo "File $file does not have any foobar, adding one."
    echo "# foobar" >> "$file"
  fi
done

