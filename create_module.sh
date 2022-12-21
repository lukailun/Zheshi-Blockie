# sh create_module.sh face_verification

upperCamelCaseClassName=""

function snakeCaseToUpperCamelCase() {
    local array=(`echo $1 | tr '_' ' '`)
    local result=''
    for var in ${array[@]}
    do 
        local firstLetter=`echo ${var:0:1} | awk '{print toupper($0)}'`
        local otherLetter=${var:1}
        result=$result$firstLetter$otherLetter
    done
    upperCamelCaseClassName=$result
}

if [ "$1" ]; then
    snakeCaseToUpperCamelCase $1 
    cd lib/app/modules
    if [ -d $1 ]; then
        echo "Deleting $1 Directory..."
        rm -rf $1
    fi
    echo "Creating $1 Directory..."
    mkdir $1
    echo "Creating $1/controllers Directory..."
    mkdir $1/controllers
    echo "Creating $1/controllers/$1_controller.dart File..."
    cat > $1/controllers/$1_controller.dart << END_TEXT
import 'package:get/get.dart';

part '$1_controller_router.dart';

class ${upperCamelCaseClassName}Controller extends GetxController {}
END_TEXT

    echo "Creating $1/controllers/$1_controller_router.dart File..."
    cat > $1/controllers/$1_controller_router.dart << END_TEXT
part of '$1_controller.dart';

extension ${upperCamelCaseClassName}ControllerRouter on ${upperCamelCaseClassName}Controller {

}
END_TEXT

    echo "Creating $1/views Directory..."
    mkdir $1/views
    echo "Creating $1/views/$1_view.dart File..."
    cat > $1/views/$1_view.dart << END_TEXT
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/$1/controllers/$1_controller.dart';

class ${upperCamelCaseClassName}View extends GetView<${upperCamelCaseClassName}Controller> {
  const ${upperCamelCaseClassName}View({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
END_TEXT

    echo "Creating $1/bindings Directory..."
    mkdir $1/bindings
    echo "Creating $1/bindings/$1_binding.dart File..."
    cat > $1/bindings/$1_binding.dart << END_TEXT
import 'package:get/get.dart';
import 'package:blockie_app/app/modules/$1/controllers/$1_controller.dart';

class ${upperCamelCaseClassName}Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ${upperCamelCaseClassName}Controller());
  }
}
END_TEXT

echo "Done!"
else
    echo "Missing Params"
fi