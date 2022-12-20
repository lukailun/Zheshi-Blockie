# sh deploy.sh

env="development"
appName="[DEV] BLOCKIE"
url="https://s.blockie.zheshi.tech/app/"
webhookUrl="https://open.feishu.cn/open-apis/bot/v2/hook/5c52cf8b-633b-4e84-a472-d008f2571ed8"
gitBranch=$(git symbolic-ref --short -q HEAD)
gitCommitId=$(git rev-parse --short HEAD)
gitCommitMessage=$(git show --pretty=format:%s -s HEAD)

if [ "$1" == "production" ]; then
  env=$1
  appName="BLOCKIE"
  url="https://frontend.blockie.fun/"
fi
sh copy_web_env.sh $env
flutter build web --web-renderer html --dart-define ENV_FILE_NAME=env/$env.env
if [ $env != "production" ]; then
  sed -i "s/<base href=\"\/\">/<base href=\"\/app\/\">/g" ./build/web/index.html
fi
sed -i "s/pushState/replaceState/g" ./build/web/main.dart.js
if [ $env == "production" ]; then
  scp -r -P 20087 ./build/web/* root@218.78.22.175:/apps/blockie_frontend/
else
  scp -r ./build/web/* root@122.112.231.151:/apps/blockie_app/
fi
curl -X POST -H "Content-Type: application/json" -d "{\"msg_type\":\"post\",\"content\":{\"post\":{\"zh_cn\":{\"title\":\"New Update\",\"content\":[[{\"tag\":\"a\",\"text\":\"$appName\",\"href\":\"$url\"},{\"tag\":\"text\",\"text\":\" has been updated.\nBranch: $gitBranch\nCommit ID: $gitCommitId\nCommit Message: $gitCommitMessage\"}]]}}}}" $webhookUrl