#!/bin/bash

# 删除旧 golang，准备替换
rm -rf feeds/packages/lang/golang

# 添加第三方软件源
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default

# 克隆 Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/package-easytier
