# Medium sources for development

### To setup new projects cd to new projects

> Scripts to get add new projects
```sh
# cd to new created folder
sh ../new_repo.sh
```

### Scripts GITHUB API

```sh
# Create Repo for Orgs
currentDir=$(pwd | sed -E 's#/.*/##')
read -p "Push to $currentDir" confirm
echo $confirm
repo="testxxx" &&
token=$GH_COM &&
curl -X POST -u teepobharu:${GH_COM} https://api.github.com/orgs/brightdays/repos -d '{"name":"'"$repo"'"}'


# For personal uses https://api.github.com/user/repos
curl -X POST -u teepobharu:${GH_COM} https://api.github.com/user/repos -d '{"name":"'"$repo"'"}'

# Delete Repo
curl -X DELETE -u teepobharu:${GH_COM}  https://api.github.com/repos/teepobharu/<reponame>

``` 

[Github API](https://docs.github.com/en/rest/reference/repos#create-a-repository-for-the-authenticated-user)