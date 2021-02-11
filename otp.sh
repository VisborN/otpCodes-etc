in=$(zbarimg $1 -q) 
#echo $in
partial=$(echo "$in" | sed -n -e 's/^.*secret=//p' )
#echo $partial
out=$(echo "$partial" | sed -n -e 's/&.*//p')
#echo $out
retval=$(oathtool --base32 --totp "$partial" 2> /dev/null)
exit_status=$?
if [ $exit_status -ne 0 ]; then
  retval=$(oathtool --base32 --totp "$out")
fi
echo $retval
echo $retval | xclip -selection c

echo $(( 30-$(date +%s)%30)) sec remaining

