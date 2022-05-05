# Tips
Using a -p switch with the mkdir command will allow you to create parent directories as needed. Using brace expansion reduces repetition. For example, mkdir -p articles/jim/sitepoint/article{1,2,3}

#testing() {
   #echo "Parameter #1 is $1"
   #echo "Parameter #2 is $2"
#}

# Use the && operator to join separate commands

~% FILE="example.tar.gz"

~% echo "${FILE%%.*}"
example

~% echo "${FILE%.*}"
example.tar

~% echo "${FILE#*.}"
tar.gz

~% echo "${FILE##*.}"
gz

# For Browsh
$ wget https://github.com/browsh-org/browsh/releases/download/v1.6.4/browsh_1.6.4_linux_amd64.deb
$ sudo dpkg -i browsh_1.6.4_linux_amd64.deb
