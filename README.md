# Blockie

A Web3 sports life platform.

## Backend
* https://www.apifox.cn/web/project/1423402

## Docs
* https://ulv7gaxq0g.feishu.cn/docx/doxcnjVqcp8bOh5UFBZgFHFhvtc

## UI/UX

* https://share.lanhuapp.com/#/invite?sid=lX0l61Yy
* https://lanhuapp.com/url/arU2S-AV8aKt
* https://mastergo.com/file/72336366832516

## Sort Imports
```
$ flutter pub run import_sorter:main
```

## Generate JSON Serialization Code
```
$ flutter pub run build_runner build --delete-conflicting-outputs
```

## How to deploy
* Development
```
$ sh deploy.sh
```
> Running `sh deploy.sh` with no parameters will run `sh deploy.sh development`.

* Production
```
$ sh deploy.sh production
```

## How to generate module structure files

<details>

* Navigate to the root directory.
* Run `create_module.sh <module_name>`.
```
$ sh create_module.sh <module_name> (eg: sh create_module.sh face_verification)
```
* It will automatically generate the directories and dart files.

![generate_module_structure_files](./pictures/generate_module_structure_files.png)

</details>