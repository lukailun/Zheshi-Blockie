# sh deploy.sh

flutter build web --web-renderer html

sed -i "s/<base href=\"\/\">/<base href=\"\/app\/\">/g" ./build/web/index.html

sed -i "s/pushState/replaceState/g" ./build/web/main.dart.js

scp -r ./build/web/* root@122.112.231.151:/apps/blockie_app/