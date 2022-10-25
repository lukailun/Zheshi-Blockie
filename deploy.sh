# sh deploy.sh

url="https://s.blockie.zheshi.tech/app/"
webhookUrl="https://open.feishu.cn/open-apis/bot/v2/hook/5c52cf8b-633b-4e84-a472-d008f2571ed8"
gitBranch=$(git symbolic-ref --short -q HEAD)
gitCommitId=$(git rev-parse --short HEAD)
#gitCommitMessage=$(git show -s --format=%s HEAD)

flutter build web --web-renderer html

sed -i "s/<base href=\"\/\">/<base href=\"\/app\/\">/g" ./build/web/index.html

sed -i "s/pushState/replaceState/g" ./build/web/main.dart.js

scp -r ./build/web/* root@122.112.231.151:/apps/blockie_app/

#curl -X POST -H "Content-Type: application/json" -d '{"msg_type":"post","content":{"post":{"zh_cn":{"title":"New Update","content":[[{"tag":"a","text":"Blockie","href":"https://s.blockie.zheshi.tech/app/"},{"tag":"text","text":" has been updated.\nbranch: '$gitBranch'\ncommit SHA: '$gitCommitId'"}]]}}}}' $webhookUrl
