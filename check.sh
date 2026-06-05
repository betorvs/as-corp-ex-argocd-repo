#!/usr/bin/env bash
export allowed_file="./bootstrap/bootstrap.yaml"

for file in $(find . -type f \( -name "*.yaml" -o -name "*.yml" \)); do
    echo "checking: $file"
    yq -e 'select(.spec.project == "default")' "$file" >/dev/null 2>&1
    if [[ "$?" -eq "0" ]]; then
        # echo "debug: $file and $allowed_file"
        if [ "$file" != "$allowed_file" ]; then 
            echo "Error: project default not allowed: $file"
            exit 1
        fi
    fi
done
echo "all good"