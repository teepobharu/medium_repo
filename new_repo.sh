#!/bin/bash

currentDir=$(pwd | sed -E 's#/.*/##')
org="brightdays"
isPrivate=false
# https://jonalmeida.com/posts/2013/05/26/different-ways-to-implement-flags-in-bash/

while getopts "ho:" OPTION
do
    if (( $OPTIND == 1 )); then
        echo "Exiting No option"
        exit
    fi
    case $OPTION in
        h)
            echo "-o for org name default = $org"
            echo "-p for private repo"
            ;;
        p) 
            echo "set as 'Private' Repo"
            isPrivate=true
        o)
            echo set org to ${OPTARG}
            # remove leading whitespace characters
            org="${OPTARG#"${OPTARG%%[![:space:]]*}"}"
            # remove trailing whitespace characters
            org="${OPTARG%"${OPTARG##*[![:space:]]}"}"   
            ;;
        \?)
            echo "Type -h for help"
            ;;
    esac

done



echo "Create repo to $currentDir"
read -p "yY or no ?" isConf

[[ $isConf =~ y|Y ]] && \
repo=$currentDir && \
token=$GH_COM && \
curl -X POST -u teepobharu:${GH_COM} https://api.github.com/orgs/brightdays/repos -d '{"name":"'"$repo"'", "private": "'"$isPrivate"'"}' > /dev/null && echo "Success adding $repo" || echo "failed to add $repo"


# User curl -X POST -u teepobharu:${GH_COM} https://api.github.com/user/repos -d '{"name":"'"$repo"'"}' > /dev/null

# Check if already a git dir
ls .git || echo "Git not init yet" && git init

# Commit
git status | grep -q ahead || echo "No commit yet"
git status | grep -q "git add" || echo "No changes yet"
read -p "Want to add all changes and commit message initial? [Y/y] " isConf
[[ isConf =~ y|Y ]] && \
git add . && \
git commit -m "inital"

# Push to remote
read -p "Want to also Push ? [Y/y] " isPush
repoSite="git@github.com:${org}/${currentDir}.git"
[[ $isPush ]] && \
git remote add origin ${repoSite} && \ 
git push -u origin master || \
echo "Please run this command to push" && \
echo "git push -u origin master"

# Submodule add 
echo "Add submodule? "
read -p "yY or no ?" isConf
[[ $isConf =~ y|Y ]] && \
cd ../ && \
git submodule add "${repoSite}"