# smssdk

轻松实现手机短信验证功能，目前只支持86的手机号


### 注册应用获取appKey和appSecret
（1）到[Mob官网](http://www.mob.com/)注册成为Mob开发者；
（2）到应用管理后台新建应用。

### iOS
在项目中的info.plist文件中添加键值对，键分别为 MOBAppKey 和 MOBAppSecret ，值为步骤一申请的appKey和appSecret

你需要重新编辑 smssdk.podspec 文件设置 dependency，

```
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'smssdk'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin.'
  s.description      = <<-DESC
A new Flutter plugin.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'mob_smssdk'
  s.ios.deployment_target = '8.0'
end
```

##### 记得添加多语言支持，不然提示信息不会根据手机语言而更改

### 用法

```
@override
  void initState() {
    Smssdk.init("2a87330c459a8", "f1509b680c66f561bf1519e891c200d3");
    super.initState();
  }

  var result = await Smssdk.getCode(phone);

  var submit = await Smssdk.submitCode(phone, code);
```

