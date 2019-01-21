# This file contains the fastlane.tools configuration
# You can find the documentation at https://docs.fastlane.tools
#
# For a list of all available actions, check out
#
#     https://docs.fastlane.tools/actions
#
# For a list of all available plugins, check out
#
#     https://docs.fastlane.tools/plugins/available-plugins
#

# Uncomment the line if you want fastlane to automatically update itself
# update_fastlane

# 定义fastlane版本号
fastlane_version “2.46.1” 

# 定义打包平台
default_platform :ios

def updateBuildNumber

currentTime = Time.new.strftime("%Y%m%d")
build = get_build_number()
if build.include?"#{currentTime}."
# => 为当天版本 计算迭代版本号
lastStr = build[build.length-2..build.length-1]
lastNum = lastStr.to_i
lastNum = lastNum + 1
lastStr = lastNum.to_s
if lastNum < 10
lastStr = lastStr.insert(0,"0")
end
build = "#{currentTime}.#{lastStr}"
else
# => 非当天版本 build 号重置
build = "#{currentTime}.01"
end
puts("*************| 更新build #{build} |*************")
# => 更改项目 build 号
increment_build_number(
build_number: "#{build}"
)
end

#指定项目的scheme名称
scheme="SwiftHud"
#蒲公英api_key和user_key
api_key="2eb1b8349ccd12db401368427dfa5059"
user_key="a5dabd67af043f363cfc29b890139266"

# 任务脚本
platform :ios do
	before_all do
    # ENV["SLACK_URL"] = "https://hooks.slack.com/services/..."
    #cocoapods
    # carthage
  	end
lane :pg do|options|
branch = options[:branch]

puts “begin packing development ipa”

#updateBuildNumber #更改项目build号

# 开始打包
gym(
scheme: "#{scheme}",
#隐藏没有必要的文件
silent: true,
# 编译前执行 clean，可减少 ipa 文件大小
clean: true,
#输出的ipa名称
output_name:"#{scheme}.ipa", #"#{scheme}_#{get_build_number()}.ipa",
# 是否清空以前的编译信息 true：是
clean:true,
# 指定打包方式，Release 或者 Debug
configuration:"Release",
# 指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development
export_method:"development",
# 指定输出文件地址
output_directory:"./fastlane/build/pgyer",
# Xcode9将不会允许你访问钥匙串里的内容，除非设置allowProvisioningUpdates
export_xcargs: "-allowProvisioningUpdates",
#export_options: {
        #provisioningProfiles: {
            #{}"com.mobile.capsa" => "dsspAdHoc",
        #}
    #}
)

puts "开始上传蒲公英"
# 开始上传蒲公英
pgyer(api_key: "#{api_key}", user_key: "#{user_key}")

end
end

