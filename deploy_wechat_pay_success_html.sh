# sh deploy_wechat_pay_success_html.sh

env="development"

if [ "$1" == "production" ]; then
  env=$1
fi
if [ $env == "production" ]; then
  scp -r -P 20087 ./web/pay_success.html root@218.78.22.175:/apps/blockie_frontend/
else
  scp -r ./web/pay_success.html root@122.112.231.151:/apps/blockie_api/public/
fi