phonebook_file="phonebook.txt"

REGION_NUM=(

"02:서울"
"031:경기"
"032:인천"
"033:강원"
"042:대전"
"051:부산"
"053:대구"
"064:제주"

)

validate_phone_number() {

    local phone_number=$1

    local region_code=${phone_number:0:3}

    local valid_region=false



    if [[ ! "$phone_number" =~ ^[0-9]{2,3}-[0-9]{4}-[0-9]{4}$ ]]; then

        echo "전화번호는 숫자와 하이픈(-)으로 입력해야 됩니다. 예: 02-1234-5678"

        return 1

    fi


    for region_info in "${REGION_NUM[@]}"; do

        region="${region_info%%:*}"

        if [[ "$region_code" == "$region" ]]; then

            valid_region=true

            break

        fi

    done


    if ! $valid_region; then

        echo "지역번호는 ${REGION_NUM[*]} 중 하나입니다."

        return 1

    fi

    return 0

}


while read -r -d ',' name && read -r -d $'\n' phone_number; do

    if ! validate_phone_number "$phone_number"; then

        echo "올바른 전화번호를 입력하세요."

        continue

    fi

    echo "${name},${phone_number}" >> "${phonenumber_file}"

done < "${phonenumber_file}"
echo


while read -r -d ',' name && read -r -d $'\n' phone_number; do

    echo "이름: ${name}"

    echo "전화번호: ${phone_number}"

    echo

done < "${phonenumber_file}"