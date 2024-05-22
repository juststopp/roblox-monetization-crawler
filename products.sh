#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
	echo "[ - ] Usage: ./passes_icons.sh <save_directory> <experience_id>"
	exit 1
fi

echo "[ + ] Removing old products.json file and $1 folder."

rm products.json
rm -rf $1

echo "[ + ] Removed products.json file and $1 folder."
echo "[ + ] Downloading new $1 list from Roblox. Universe ID: $2"

curl -sSL -H 'accept: */*' \
	-H 'accept: */*' \
	-H 'accept-language: en-US,en;q=0.9' \
	-H "cookie: $ROBLOX_COOKIE" \
	-H 'dnt: 1' \
	-H 'origin: https://create.roblox.com' \
	-H 'priority: u=1, i' \
	-H 'referer: https://create.roblox.com/' \
	-H 'sec-ch-ua: "Chromium";v="125", "Not.A/Brand";v="24"' \
	-H 'sec-ch-ua-mobile: ?0' \
	-H 'sec-ch-ua-platform: "macOS"' \
	-H 'sec-fetch-dest: empty' \
	-H 'sec-fetch-mode: cors' \
	-H 'sec-fetch-site: same-site' \
	-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
	"https://apis.roblox.com/developer-products/v1/universes/$2/developerproducts?pageNumber=1&pageSize=50" >products.json

echo "[ + ] Downloaded new Products list from Roblox and saved in passes.json"

echo " "
echo "[ + ] Downloading Products from $1 file."
echo " "
json_data=$(cat "products.json")

items=0

for obj in $(echo "${json_data}" | jq -r '.[] | @base64'); do
	_jq() {
		echo "${obj}" | base64 --decode | jq -r "${1}"
	}

	id=$(_jq '.id')
	name=$(_jq '.name')

	url="https://thumbnails.roblox.com/v1/developer-products/icons?developerProductIds=${id}&size=150x150&format=png"

	image_url=$(curl -sSL -H 'accept: */*' \
		-H 'accept: */*' \
		-H 'accept-language: en-US,en;q=0.9' \
		-H "cookie: $ROBLOX_COOKIE" \
		-H 'dnt: 1' \
		-H 'origin: https://create.roblox.com' \
		-H 'priority: u=1, i' \
		-H 'referer: https://create.roblox.com/' \
		-H 'sec-ch-ua: "Chromium";v="125", "Not.A/Brand";v="24"' \
		-H 'sec-ch-ua-mobile: ?0' \
		-H 'sec-ch-ua-platform: "macOS"' \
		-H 'sec-fetch-dest: empty' \
		-H 'sec-fetch-mode: cors' \
		-H 'sec-fetch-site: same-site' \
		-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
		"${url}" | jq -r '.data[0].imageUrl')

	if [[ "${image_url}" != "null" ]]; then
		curl -sSL -o "${name}.png" \
			-H 'accept: */*' \
			-H 'accept-language: en-US,en;q=0.9' \
			-H "cookie: $ROBLOX_COOKIE" \
			-H 'dnt: 1' \
			-H 'origin: https://create.roblox.com' \
			-H 'priority: u=1, i' \
			-H 'referer: https://create.roblox.com/' \
			-H 'sec-ch-ua: "Chromium";v="125", "Not.A/Brand";v="24"' \
			-H 'sec-ch-ua-mobile: ?0' \
			-H 'sec-ch-ua-platform: "macOS"' \
			-H 'sec-fetch-dest: empty' \
			-H 'sec-fetch-mode: cors' \
			-H 'sec-fetch-site: same-site' \
			-H 'user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36' \
			"${image_url}"
		echo "[ + ] Downloaded image for name: ${name}"
		items=$((items + 1))
	else
		echo "[ - ] Failed to fetch image URL for name: ${name}"
	fi
done

echo " "
echo "[ + ] Creating $1 folder."
mkdir $1
echo "[ + ] Created $1 folder."

echo " "
echo "[ + ] Downloaded ${items} Products from products.json file. Saving in $1."

mv *.png $1

echo "[ + ] Moved ${items} files in $1."
