#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default
# sed -i '$a src-git small8 https://github.com/kenzok8/small-package' feeds.conf.default
# 添加官方 packages 源
sed -i '1i src-git packages https://git.openwrt.org/feed/packages.git' feeds.conf.default

# 添加官方 luci 源
sed -i '2i src-git luci https://git.openwrt.org/feed/luci.git' feeds.conf.default

# 添加官方 routing 源
sed -i '3i src-git routing https://git.openwrt.org/feed/routing.git' feeds.conf.default

# 添加官方 telephony 源
sed -i '4i src-git telephony https://git.openwrt.org/feed/telephony.git' feeds.conf.default
# 自定义软件源
sed -i '5i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '6i src-git small https://github.com/kenzok8/small' feeds.conf.default
# Easytier
git clone --depth 1 -b main https://github.com/EasyTier/luci-app-easytier.git package/package-easytier
