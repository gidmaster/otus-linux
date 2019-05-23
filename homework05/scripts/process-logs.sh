#!/bin/bash
runLogFile=$RUN_LOG
accessLogFolder=$ACCESS_LOG
errorLogFolder=$ERROR_LOG

print-ip() 
{

    awk -v line=$2 'NR > line {print $1}' $1 | sort | uniq -c # > ip.txt
}
print-urls()
{
    tail -n +$2 $1 | sed -nr 's/.*\"[A-Z]{3,8} (.*) HTTP.*/\1/p' | sort | uniq -c # > urls.txt
}
print-errors()
{
    tail -n +$2 $1 | sed -nr 's/.*\[error\] [0-9]{1,10}#[0-9]{1,5}: \*[0-9]{1,10}(.*)\, client.*/\1/p' # > error.txt
}
print-codes()
{
    tail -n +$2 $1 | sed -nr 's/.*\" ([0-9]{3}) .*/\1/p' | sort | uniq -c # > codes.txt
}

get-date()
{
    cDate=$(awk -v line=$2 'NR == line {print $4}' $1 | awk 'BEGIN {FS="[ :/]*"} {gsub(/[\[\]]/,"", $0); print $1" "$2" "$3" "$4":"$5":"$6" "$7}')
    date -d "$cDate"
}

get-date-errors()
{
    cDate=$(awk -v line=$2 'NR == line {print $1 " " $s}' $1 | awk 'BEGIN {FS="[ :/]*"} {gsub(/[\[\]]/,"", $0); print $2"/"$3"/"$1" "$7":"$5":"$6}')
    date -d "$cDate"
}

if [[ !(-e $runLogFile || -s $runLogFile) ]]; then
    echo "Run for the first time"
    touch $runLogFile
    echo "access,$(ls -t $accessLogFolder | grep access* | head -1),1" >> "$runLogFile"
    echo "error,$(ls -t $errorLogFolder | grep error* | head -1),1" >> "$runLogFile"
fi

fileAccess=$(echo $(grep "access" $runLogFile) | awk '{print $2}' FS=",")
lineAccess=$(echo $(grep "access" $runLogFile) | awk '{print $3}' FS=",")
accessEnd=$(wc $fileAccess | awk '{print $1}')

fileErrors=$(echo $(grep "error" $runLogFile) | awk '{print $2}' FS=",")
lineErrors=$(echo $(grep "error" $runLogFile) | awk '{print $3}' FS=",")
errorEnd=$(wc $fileErrors | awk '{print $1}')

echo "Information from Web Server."

if [[ $accessEnd -eq $lineAccess ]]
then
    echo "No new data since $(get-date $fileAccess $lineAccess)"
else
    echo "Hey here some log information from $(get-date $fileAccess $lineAccess) to $(date)"
    echo "Source IPs"
    echo
    print-ip $fileAccess $lineAccess
    echo "Requested URLs"
    echo
    print-urls $fileAccess $lineAccess
    echo "Response codes"
    echo
    print-codes $fileAccess $lineAccess
    
    sed -i 's@.*access.*@access,'$fileAccess','$accessEnd'@g' $runLogFile
fi

if [[ $errorEnd -eq $lineErrors ]]
then
    echo "No new errors since $(get-date-errors $fileErrors $lineErrors)"
else
    echo "Hey here errors information from $(get-date-errors $fileErrors $lineErrors) to $(date)"
    echo "errors"
    echo
    print-errors $fileErrors $lineErrors
    sed -i 's@.*error.*@error,'$fileErrors','$errorEnd'@g' $runLogFile
fi
