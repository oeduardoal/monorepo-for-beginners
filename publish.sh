if [[ $(git describe --exact-match 2> /dev/null || :) =~ -next ]];
then
  echo "Publishing canary"
  lerna publish prerelease --yes --preid next --dist-tag next
  
  if [[ ! $? -eq 0 ]];then
    exit 1;
  fi
else
  echo "Did not publish canary"
fi

if [[ ! $(git describe --exact-match 2> /dev/null || :) =~ -next ]];then
  echo "Publishing stable"
  lerna publish --yes --conventional-graduate --create-release github
  
  if [[ ! $? -eq 0 ]];then
    exit 1;
  fi
else
  echo "Did not publish stable"
fi