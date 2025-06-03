#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
# 更新所有 feeds
./scripts/feeds update -a

# 克隆替换 golang
git clone --depth 1 https://github.com/kenzok8/golang feeds/packages/lang/golang

# 安装所有 feeds
./scripts/feeds install -a

# 删除可能冲突或重复的包（如果确实需要）
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat

# 去掉 gn 包的 -Werror，避免编译因警告失败
find feeds/packages/devel/gn -type f -exec sed -i 's/-Werror//g' {} +
# 修改默认IP地址
sed -i "s/192.168.1.1/172.18.18.222/g" package/base-files/files/bin/config_generate
# 修改设备说明
sed -i "s/DISTRIB_DESCRIPTION=.*/DISTRIB_DESCRIPTION='GanQuanRu.Co $(date +"%y%m%d")'/g" package/base-files/files/etc/openwrt_release
# OpenClash
mkdir -p files/etc/openclash/core
# CLASH_DEV_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz"
# CLASH_TUN_URL=$(curl -fsSL https://api.github.com/repos/vernesong/OpenClash/contents/master/premium\?ref\=core | grep download_url | grep amd64 | awk -F '"' '{print $4}')
CLASH_META_URL="https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz"
GEOIP_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat"
GEOSITE_URL="https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat"
# wget -qO- $CLASH_DEV_URL | tar xOvz > files/etc/openclash/core/clash
# wget -qO- $CLASH_TUN_URL | gunzip -c > files/etc/openclash/core/clash_tun
wget -qO- $CLASH_META_URL | tar xOvz > files/etc/openclash/core/clash_meta
wget -qO- $GEOIP_URL > files/etc/openclash/GeoIP.dat
wget -qO- $GEOSITE_URL > files/etc/openclash/GeoSite.dat
chmod +x files/etc/openclash/core/clash*
