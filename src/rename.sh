cd ./directory
cnt=1
for fname in *
do
    mv "$fname" "$cnt.jpg"
    cnt=$(( $cnt + 1 ))
done