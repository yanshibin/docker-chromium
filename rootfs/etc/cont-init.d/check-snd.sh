#!/bin/sh

set -e # 立即退出，如果命令返回非零状态。
set -u # 将未设置的变量视为错误。

log() {
    echo "[cont-init.d] $(basename $0): $*"
}

SND_DEV="/dev/snd"

if [ ! -d "$SND_DEV" ]; then
    log "sound not supported: device $SND_DEV not exposed to the container."
    exit 0
fi

# 检测声音设备的关联组。
SND_GRP="$(find "$SND_DEV" -maxdepth 1 -not -type d -exec stat -c "%g" {} \; | sort -u | tail -n1)"
log "sound device group $SND_GRP."
# 确保目标目录存在。
if [ ! -d /var/run/s6/container_environment ]; then
    mkdir -p /var/run/s6/container_environment
fi
# 向 SUP_GROUP_IDS 添加声音组 ID。
if [ -f /var/run/s6/container_environment/SUP_GROUP_IDS ]; then
    echo -n "," >> /var/run/s6/container_environment/SUP_GROUP_IDS
fi
echo -n "$SND_GRP" >> /var/run/s6/container_environment/SUP_GROUP_IDS

# vim: set ft=sh :
