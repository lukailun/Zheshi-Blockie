# blockie_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## UI/UX

* https://share.lanhuapp.com/#/invite?sid=lX0l61Yy
* https://lanhuapp.com/url/arU2S-AV8aKt

## How to generate module structure files

<details>

* Navigate to the root directory.
* Run `create_module.sh`.
```
$ sh create_module.sh <module_name> (eg: sh create_module.sh face_verification)
```
* It will automatically generate the directories and dart files.

![generate_module_structure_files](./pictures/generate_module_structure_files.png)

</details>

## How to use `BasicAppBar`

<details>

### App Bar with Back Button

![app_bar_with_back_button](./pictures/app_bar_with_back_button.png)

```dart
BasicAppBar()
```

### App Bar with Trailing Buttons

![app_bar_with_trailing_buttons](./pictures/app_bar_with_trailing_buttons.png)

```dart
BasicAppBar(
    actionItems: [
        AppBarButtonItem(
            assetName: "images/app_bar/share.png",
            onTap: () {},
        ),
        AppBarButtonItem(
            assetName: "images/app_bar/menu.png",
            onTap: () {},
        ),
    ],
)
```

### App Bar with Trailing Flat Buttons without Back Button

![app_bar_with_trailing_flat_buttons_without_back_button](./pictures/app_bar_with_trailing_flat_buttons_without_back_button.png)

```dart
BasicAppBar(
    showsBackButton: false,
    buttonStyle: AppBarButtonStyle.flat,
    actionItems: [
        AppBarButtonItem(
            assetName: "images/app_bar/share.png",
            onTap: () {},
        ),
        AppBarButtonItem(
            assetName: "images/app_bar/menu.png",
            onTap: () {},
        ),
    ],
)
```

### App Bar with Popup Menu Button

![app_bar_with_popup_menu_button](./pictures/app_bar_with_popup_menu_button.png)

```dart
BasicAppBar(
    buttonStyle: AppBarButtonStyle.flat,
    actionItems: [
        AppBarButtonItem(
            assetName: "images/app_bar/share.png",
            onTap: () {},
        ),
        AppBarButtonItem(
            assetName: "images/app_bar/menu.png",
            items: [
                AppBarButtonItem(
                    title: '首页',
                    assetName: "images/app_bar/home.png",
                    onTap: () {},
                ),
                AppBarButtonItem(
                    title: '我的',
                    assetName: "images/app_bar/user.png",
                    onTap: () {},
                ),
                AppBarButtonItem(
                    title: '铸造规则',
                    assetName: "images/app_bar/info.png",
                    onTap: () {},
                ),
            ],
        ),
    ],
)
```

</details>