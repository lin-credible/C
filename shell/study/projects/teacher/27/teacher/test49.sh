#!/bin/bash
#comment
backDir="/opt/backup/`date +%Y.%m`"
[ ! -d "$backDir" ] && mkdir -p "$backDir"
backFile="etc-`date +%Y.%m.%d`.tar.bz2"
cd /
tar cjf "${backDir}/${backFile}" abc #使用/abc目录来测试
echo "Done"
exit 0;
