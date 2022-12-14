#!/bin/bash
readDir(){
    local dir=$1
    local files
    files=$(ls "$dir")
    for file in $files; do
        local path="$dir/$file"
        if [ -d "$path" ];then
            echo "# $file" > $path/index.md
            echo "- **[${file%.*}](./$file/index.md)**" >> $dir/index.md
            readDir "$path"
        else
            if [ $file != "index.md" ]; then
                echo "- [${file%.*}](./$file)" >> $dir/index.md
            fi
        fi
    done
}

readDir ./docs
