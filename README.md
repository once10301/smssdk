# smssdk

轻松实现手机短信验证功能，目前只支持86的手机号


### 注册应用获取appKey和appSecret
（1）到[Mob官网](http://www.mob.com/)注册成为Mob开发者；
（2）到应用管理后台新建应用。

### iOS
在项目中的info.plist文件中添加键值对，键分别为 MOBAppKey 和 MOBAppSecret ，值为步骤一申请的appKey和appSecret。
会提示NSContactsUsageDescription，目前没有接入好友关系功能，可以不用理会。

##### 记得添加多语言支持，不然提示信息不会根据手机语言而更改

### Android

在build.gradle里添加

```java
buildscript {
    repositories {
        google()
        jcenter()
        maven {
            url "http://mvn.mob.com/android"
        }
    }

    dependencies {
        classpath 'com.android.tools.build:gradle:3.2.1'
        classpath 'com.mob.sdk:MobSDK:+'
    }
}

allprojects {
    repositories {
        google()
        jcenter()
        maven {
            url "http://mvn.mob.com/android"
        }
    }
}
```

在Manifest清单文件中配置：tools:replace=”android:name”

```xml
<application
   tools:replace="android:name">
```

### 用法

```dart
  @override
  void initState() {
    Smssdk.init("2a87330c459a8", "f1509b680c66f561bf1519e891c200d3");
    super.initState();
  }

  var result = await Smssdk.getCode(phone);

  var submit = await Smssdk.commitCode(phone, code);
```

