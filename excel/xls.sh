# /bin/bash
HOST="https://demo1.at.venturestesting.com/manufacture"

curl -X POST "$HOST/api/user/login" -c ./cookiefile -H Content-Type:application/json  -d '{
  "username":"adminUser",
  "password":"Vate$1234"
}' | sed 's/"/ /g' | awk '{print $2,$3}'

python  XlsxToJson.py -f  ~/Desktop/demo_mock_data.xlsx -s Asset\ details -w ./assetDetails.json
python  XlsxToJson.py -f  ~/Desktop/demo_mock_data.xlsx -s Locations -w ./assetLocation.json

let lenAsset=$(jq '. | length ' ./assetDetails.json)
for (( i=0; i<$lenAsset; i++))
do
  body=$(jq .[$i] ./assetDetails.json)
  curl -X POST "$HOST/api/assetTemplate/" -d "$body" -b ./cookiefile -H Content-Type:application/json
  echo
done

let lenLocation=$(jq '. | length ' ./assetLocation.json)
for (( j=0; j<$lenLocation; j++))
do
  body=$(jq .[$j] ./assetLocation.json)
  curl -X POST "$HOST/api/location/" -d "$body" -b ./cookiefile -H Content-Type:application/json
  echo
done

find ../public/demoImg/* -print0 | while read -d $'\0' filename
do
echo '{
    "fileContent": "' > tmp
base64 "$filename" >>tmp
echo '",
    "fileName": "'$filename'",
    "isImage":true,
    "dataType":"image/'${filename##*.}'"
  }' >> tmp
curl -X POST "$HOST/api/file" -b ./cookiefile -H Content-Type:application/json -d @tmp
echo
done

rm -f ./assetDetails.json ./assetLocation.json ./cookiefile ./tmp