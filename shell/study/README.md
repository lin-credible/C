###Where there is a shell, there is a way.

SHELL Scripts Programming
bash (CentOS)
shell?

where is shell?

常见的shell种类
```
cat /etc/shells
chsh -l
ls /bin/*sh 
ls /sbin/nologin
rpm -ivh tcsh ksh
```

shell环境的切换

临时切换:
```
ps u #ps aux
pstree | grep "sh"
ksh
csh

echo $SHLVL #shell的层数

chsh
usermod -s /sbin/nologin tom
```
bash的常用快捷键
```
tab
两次tab
ctrl + i
ctrl + a
ctrl + e
ctrl + f
ctrl + b
ctrl + k
ctrl + u
ctrl + l
ctrl + p
alt  + . 上一条命令的最后一个参数
```
6. 命令历史

vim /etc/profile
HISTSIZE=5, history的结果就只有最近的5条了, 退出时, 自动将这5条覆盖写入~/.bash_history, 
. /etc/profile #将/etc/profile看成一个脚本文件
登录时, 读~/.bash_history, 文件中命令数目也被截为HISTFILESIZE的值.  
set | grep HISTSIZE
!10
!f #最近执行过fdisk -l /dev/sda
!! #上一条
shell脚本中的特殊字符
```
""
''

\ 单字符转义
"" 弱字符串转义($ !不可以)
'' 强字符串转义

echo \*

echo  "* *"
echo "$USER"
echo "!!"
换成单引号

`` #echo "aa $LOGNAME, `date +%T` bb cc"
;
&
() 创建成组的命令, 在子shell中运行, a=( $( ls ) ), 注意a会成为数组
{} 组合 touch a{1,2,3,4}
  创建命令块, 或叫匿名函数
|
```

Linux 默认提供了三个I/O 通道
Standard Input, 文件描述符: 0, 默认是键盘
Standard Output, 文件描述符: 1, 默认是终端显示器
Standard Error, 文件描述符: 2, 默认是终端显示器

几条命令:
```
cut -d: -f1 /etc/passwd | sort -r | less
ls -l | mail -s 'file list' tom@gmail.com
cat files_to_delete.txt | xargs rm -f #将输入转化为参数列表
ls *.sh | xargs rm -f

env | tee env.out

< #tr 'a-z' 'A-Z' < file1
>
* ? [] ^ 模式匹配 #[]有且仅有1个 ?也是有且仅有1个
!
$ 取变量的值
#
空格, 制表符, 换行符 当做空白
```


特殊符号:
```
${var1}
`` $(cmd) 命令替换
( cmd1; cmd2 ) &> /dev/null 子shell中执行命令, 注意可以取得当前父shell的本地变量
{ cmd1; cmd2; } &> /dev/null 当前shell中执行命令

a=$(( 10 + 20 )) 数学运算(POSIX标准的扩展)
a=$[ 10 + 20 ] 数学运算
(( a = 10 + 20 ))

(())复合命令, 做整数算术运算或算术比较, (( a=10*2 )), (( 10-10 )), (( 10>5 )), (( 10>20 )), 查看$?的值, 算出值非0则$?返回0
(( a += 1 ))
(( a=b % c ))
```

推荐作法: 整数数值的比较、运算均用(())
```
while (( a < b )); do
done
if (( a == 0 )); then
fi
for (( i=1; i<=5; i++ )); do
done
```
推荐作法: 字符串的比较用[[]]

> if [[ $a = true ]]

[] 必选其中一个 grep "ro[opq]t"
  测试: if [ 5 -gt 4 ]
  if [[ "abc" == "def" ]]
() 数组 (0 1 2 3 4)
&& 
|| 


shell的特性

命令别名
```
ls -lth #t 按修改时间排序, ls -l即修改时间
alias
unalias
```
**别名 函数 内部命令 外部命令**

shell不需要启动一个单独的进程来运行内部命令

shell需要创建(fork)和执行(exec)一个新的子进程来运行外部命令

命令替换
```
userNum=`w | grep "tty" | wc -l`
rpm -qf `which fdisk`
rm -rf `find / -user tom`
pkg=$(rpm -qf $(which fdisk)) #里面的$()也可换成``
```


|与重定向

```
ls > file1 2>&1
ls &> file1
ls &>> file1 #bash4.0或以上支持
grep "tom" /etc/passwd &> /dev/null
cat > /etc/yum.repos.d/rhel.repo << EOF
abc
def
EOF
```

shell的输入输出控制
```
echo -n "abc"
echo -e "abc\t\tabc"

a=abc
b=def
a=$a'\n'$b
echo $a
echo -e $a

name='tom'
printf 'name is %s\n' $name
```

读取用户输入: read
```
read var1
read var1 var2 var3
read -p "please input a num: " var1
read -s pwd #不显示出来
```

变量分类

- 本地变量(用户自定义变量)
```
var1=ds
var1="ds tech"
var1='ds tech'
var2="cs $var1 cs"
var2='cs $var1 cs'
echo $var1
echo ${var1}23

echo ${var1:+$var2}
echo $var1 $var2

echo ${var1:-$var2}
echo $var1 $var2

echo ${var1:?$var2}
echo $var1 $var2

echo ${var1:=$var2}
echo $var1 $var2

var1=abcdefghij
echo ${var1:3:2}
echo ${var1:3}
echo ${#var1}

expr length $var1
expr substr $var1 3 2
expr substr $var1 3 99

declare -i sum=10+20+30
readonly
declare -r sum
set
unset var1
```

环境变量
```
var1=colin.com
export var1
export var1=colin.com

declare -x sum
export | grep "sum"
env
printenv

PATH #仅对外部命令
HOME
UID
HOSTNAME
PWD
```

位置参数变量
```
$0 $1 ... ${10}
service#$0 network#$1 restart#$2
```

关于循环获取位置参数变量:

$1 $2 $3 ...
1 增长到2 3 ...
i=1 i++
$$i, 这样是不行的, shell不支持变量名是变量,

方法1: shift
使用shift, 执行一次shift, 位置参数往左移一个, 原先的$2变成了$1,
只要获取$1即可获取后面的$2 $3 ...的值
```
while (( $# > 0 ))
do
echo $1;
shift;
done
exit 0;
```
方法2: 使用$@
```
for i in "$@"
do
echo "$i";
done
exit 0;
```
方法3: 间接引用
```
i=1;
while (( i <= $# ))
do
echo ${!i};
let i++; #(( i++ ))
done
exit 0;
```

预定义变量(特殊变量)
```
$#
$$ #本shell的PID值, 当前进程ID号

$@ $*
"$*"以"$1 $2..."的形式保存所有输入的命令行参数
"$@"以"$1" "$2"...的形式
for i in "$*" 或 "$@"
do
echo $i;
done
```

$? #[0, 255]整数
每个命令在退出时都会返回一个退出状态值(exit status)
正常退出, 返回0
异常退出, 返回非0
退出状态值保存在特殊变量$? 中

算术运算

仅整数

bash只支持整数的运算, 浮点数运算可以使用bc
echo "scale=3; 13/2" | bc #scale为小数点位数
```
declare -i a
a=5+5

a=1+2
echo $a
echo 1+2

expr 1 \* 2
USAGE=$( expr $USED \* 100 / $TOTAL )

echo $[ 10 * 20 ]
echo $(( 3**(1+1+1) )) #()用来改变运算顺序
(( a=10 * 20 )) #(())主要用来数学计算

let a=5+9 #let常用来赋值
let b=$a-3 c=$a*2 c=$a/3 d=$a%3
declare -i a=3**3

a=3
let b=$a**3

let a++
let a+=10
```

浮点数运算
```
rpm -q bc
bc
echo "3.14*2" | bc
echo "scale=3; 10/3" | bc #3位小数
```

数组

在白板上画出数组图, 0号元素, 1号元素, 2号元素
目前只支持一维数组
索引数组
```
names[0]=colin
names[1]=jerry
names[2]=lee
names[3]=kevin
```

遍历数组:
```
for i in ${names[@]}
do
echo $i;
done
```
```
names[x++]=colin
names[x++]=jerry
names[x++]=lee
names[x++]=kevin
```
用在循环中就很好的生成了数组, 或将一些值逐一放入数组中如: 
```
for i in tom jerry lee mike
do
names[x++]=$i;
done
for i in ${names[@]}
do
echo $i;
done
```

```
r=( `route -n | grep "UG"` ) #r变成了数组
echo ${r[3]}

var1="aa bb cc"
var2=( $var1 ) #var2变成了数组
echo ${var2[1]}
```

```
echo ${names[0]}

names=(colin jerry lee kevin)
names=([0]=colin [1]=jerry [3]=lee [5]=kevin cali)
names=(tom [5]=jerry lee)

echo ${names[@]}
echo ${names[*]}

echo ${#names[@]}
echo ${#names[*]}
echo ${!names[@]} #打印下标值
echo ${!names[*]}

echo ${names[2]}
echo ${#names[2]}

unset names
unset names[2]
```

关联数组
bash 4.0版本开始支持关联数组
```
declare -A a
a=([userName]=tom [pwd]=password1 [age]=20 [addr]=hncs)
a[gender]=male
```

bash的启动配置文件(环境变量配置文件)

登录shell
login shell 指的是输入用户名、密码, 从系统登录时执行的第一个程序
```
/etc/profile

/etc/profile.d/*.sh

~/.bash_profile

~/.bashrc

/etc/bashrc
```

非登录shell
登录系统后, 在login shell里启动的shell是非login shell
如执行bash命令、在图形中打开终端均是开一个非登录shell
login shell与non login shell在启动时执行不同的初始化脚本
```
/etc/profile.d/*.sh
~/.bashrc
/etc/bashrc
```
su例子:
su tom #非登录shell, 执行哪些文件?
su - tom #登录shell, 执行哪些文件?

退出登录shell时, 执行~/.bash_logout

执行shell脚本的方法

chmod +x test.sh
./test.sh #在子shell中执行, 一般用这种方法

bash test.sh #在子shell

source test.sh #. test.sh, 在当前shell
echo $a #a是在test.sh中定义的一个变量

运行多个命令
cd /tmp; ls

在子shell中运行命令
( cd /tmp; ls )

命令的返回值$?


有条件地运行多个命令(列表)
ls file1 &> /dev/null && cat file1

bash的只读变量
$?
$$ 当前shell的PID
$_ 前一个命令的最后参数
$PPID shell父进程的PID
UID
bash预赋值的变量
BASH_VERSION
OLDPWD
RANDOM

{}替换
mkdir chap{01,02,03,04}
mkdir -p chap{01,02,03,04}/{html,text}
touch file{1..10}

一条find命令
```
find /etc -name *.conf
touch a.conf b.conf
find /etc -name *.conf
find /etc -name "*.conf" #用""引起来
```
bash shell的基本语法

条件测试
任何命令都可以作为条件, 执行并检查命令的返回值

```
if [ ! -d "/tmp/{sda1,sda3}" ]
then
( mkdir /tmp/{sda1,sda3} > /dev/null 2>&1 )
fi


if ls $1
then
chmod 600 $1;
else
echo "the file $1 does not exist";
fi;


if test -e $1
if [ -e $1 ]
```


对命令执行结果的判断:
```
if rpm -q gcc
then 
echo yes; 
else 
echo no; 
fi

rpm -q gcc && echo 'ok' || echo 'please install gcc !';
```

测试文件状态:
```
test -r "$file1" -a -s "$file1"
[ -f file1 ]

[ -d /etc/vsftpd ]
echo $?

[ -e /mnt/Server ] && echo 'yes' || echo 'no';
```

整数值比较:
中间可用逻辑运算符: -a -o !
```
[  $a -gt $b -a $b -gt $c ]  && echo 'a is largest'
[ `who | wc -l` -le 10 ] && echo 'ok'

var1=`df -hT | grep "/boot" | awk '{print $6}' | cut -d "%" -f 1`
[ $var1 -gt 90 ] && echo 'ok'

if (( a > b && b > c ))
then
echo 'a is largest';
fi
```

字符串比较:
=或== 两个字符串相等
!= 两个字符串不等
-z 空字符串
-n 非空字符串

[[]]主要用来字符串比较
```
if [[ $location =~ "-" || $location =~ "^:" ]] #包含有-, 或以:开头, ":$", 以:结尾

    
[[ "$a" == "abc" ]] #字符串比较一般用[[]], 变量$a用""括起来, 防止$a的值中有空格

read -p  "input: " file
[[ "$file" = "/etc/fstab" ]] && echo "ok";

[[ $LANG != "en.US" ]] && echo $LANG

[[ -z `cat file1` ]] && echo "ok";
```

逻辑测试(逻辑判断)(列表)
```
[[ "$USER" = "tom" ]] || echo "not tom";

[ -f /etc/file1 -o -f /etc/file2 ] && echo "ok"

[ ! -x /etc/file1 ] && echo "no exec"

[[ $USER == "root" && $SHELL = "/bin/bash" ]] && echo "ok"
```

if

if 命令
then
...
fi

若一条命令成功执行了, 就做什么, 没成功, 就做什么,
3种做法:
1.
```
if ls -d /dir1
then
echo "ok";
else
echo "fail";
fi
```

2.
```
ls -d /dir
if (( $? == 0 )) #[ $? -eq 0 ]
then
echo "ok";
else
echo "fail";
fi
```

3. 列表
```
ls -d /dir && echo ok || echo fail;
```

```
if ping -c3 server1
then
echo 'server1 is up';
fi


echo -n "how old are you"
read age
if (( age <= 0 || age >= 120 ))
then
echo "error"
exit 1;
fi


if [ -r $file -a -w $file -a -x $file ]


a=0;
if test $a -eq 1
then 
echo "yes";
else
echo "no";
fi;


a="abcdefg";
if echo $a | grep "abc"
then
echo yes;
else
echo no;
fi;


file1="/var/log/messages"
if [ -f $file1 ]
then
wc -l $file1
fi


read -p "input: " dir1
if [ -d $dir1 ] 
then
echo "$dir1 exist";
else
echo "$dir1 not exist";
mkidr $dir1;
fi 


uNum=`who | wc -l`
if (( uNum > 3 )) #[ $uNum -gt 3 ]
then
echo "$uNum";
else
echo "...";
who | awk '{print $1,$2}'
fi


pgrep "vsftpd" &> /dev/null
if [ $? -eq 0 ]
then
echo ...;
elif [ -x "/etc/init.d/vsftpd" ]
then
service vsftpd start
else
echo "no";
fi;


service mysqld status &> /dev/null;
if [ $? -ne 0 ]
then
echo "at time: `date` mysql is down" >> /var/log/messages;
service mysqld restart;
fi
```


for语句:
```
for day in "Monday" "Wednesday" "Friday"
do
echo $day;
done
```

```
for i in `cat iplist`
do
echo $i;
done | tee file1
mail -s "WRONG!" u1@ds.com,u2@ds.com < file1


for file in /boot/*
do
echo "$file"; #basename "$file";
done


for i in `find | grep "xml$" | grep "^comps"`
do
  createrepo -g ${i} Server/
done



for file in "$@" #简写为for file
do
if [ -e $file ]
...
done

for i in "$@"
for i in /etc/*.conf
for i in $(command)


for dir in "$@"
do
if [ -d $dir ]
then
if [ "$dir" == "." -o "$dir" == ".." ] #[[ "$dir" == "." || "$dir" = ".." ]]
then
echo "skipping ..."
else
basename $dir 
tar czf $dir.tgz $dir && rm -rf $dir
fi
else
echo "skipping non directory $dir";
fi
done


dir1="/opt/*"
lmt=20
u=`grep "/bin/bash" /etc/passwd | cut -d ":" -f 1`
for user in $u
do
num=`find $dir1 -user $user | wc -l`
if [ $num -gt $lmt ]
then
echo "$user have $num files"
fi
done


for i in `seq 1 9` #seq 9
for i in $( ls )
for i in /opt/*


result=0;
while [ $# -gt 0 ]
do
result=`expr $result + $1`;
shift;
done 
echo "the sum is: $result";


for i in $* #$@也可, 或简写成for i也可
do
echo $1;
shift;
done


for i in `seq 1 6` #{1..6} 或seq 6
do
if (( $i % 2 == 0 ))
then
break; #continue break与continue的使用
fi
echo $i;
done
echo "over";


for (( i=0; i<=3; i++ ))
do
echo;
for (( j=0; j<=5; j++))
do
echo -n "$i, $j";
[ $j == 3 ] && break #continue;
done
done


while :
do
read -p "input a string: " str
echo $str >> /tmp/input.txt
if [[ "$str" == "END" ]]; then
break;
fi
done
wc /tmp/input.txt
rm -f /tmp/input.txt


i=1
while (( i <= 20 )) #[ $i -le 20 ]
do
if [ $i -eq 8 ] || [ $i -eq 18 ]; then
let i++;
continue;
fi
userdel -r stu$i
let i++;
done


size=$( ls -l $( find /etc -type f -a -name "*.conf" ) | awk '{print $5}' )
#find /etc -type f -name "*.conf" | xargs ls -l | awk '{print $5}'
total=0
for i in $size
do
total=`expr $total + $i` #let total+=i (( total+=i ))
done
echo "total size is $total"


counter=0
for i in 1 2 3 4 5
do
(( counter++ ))
(( counter+=1 ))
counter=$(( $counter+1 ));
counter=$[ $counter+1 ]
counter=$( expr $counter + 1 );
let counter+=1;
let counter++;
done
echo $counter;
```

类c风格的for
```
for (( i = 1; i <= 10; i++))
do
echo $i;
done
```


while
while 命令
do
...
done


while读文件内容:
```
vim test1.sh
while read user groups homedir 
do 
echo -e "\$user=$user\t\$groups=$groups\t\$homedir=$homedir" 
    gid=$( echo $groups | cut -d, -f1 )
    echo "\$gid=$gid" 
    sleep 2
done < file2

vim file2
tom g1,g2,g3 /home/tom
jerry g1,g2 /home/jerry
lee g1 /home/lee

```

```
#!/bin/bash
PRICE=$( expr $RANDOM % 1000 ) 
#$RANDOM % 10 [0, 10)之间的随机数
#$RANDOM % 20 [0, 20)之间的随机数

TIMES=0
echo "0-999之间, 猜猜看是多少？"

while :
do
    read -p "请输入你猜测的价格数目: " INT
    let TIMES++
    if [ $INT -eq $PRICE ]
then
        echo "猜对了, 实际价格是 $PRICE"
        echo "你总共猜测了 $TIMES 次"
        exit 0
    elif [ $INT -gt $PRICE ]
then
        echo "太高了!"
    else
        echo "太低了!"
    fi
done
```


用while 循环从文件中读取数据
```
while read LINE
do
echo $LINE
done < /etc/hosts


while read ip hn
do
echo "$hn --> $ip"
done < /etc/hosts
```

```
a=3;
while [ $a -gt 0 ]
do
echo $a;
a=$[ $a -1 ]; #let a--;
done


i=1;
while [ $i -le $# ]
do
echo ${!i} #间接变量引用, 实用
let i++;
done
```

创建20个文件夹dir01 - dir20
```
fun1()
{
[ ! -d $1 ] && { mkdir $1; echo "$1 create ok"; } || echo "$1 exist";
}
a=20;
while [ $a -gt 0 ]
do
if [ $a -le 9 ]
then
b="0${a}";
fun1 dir${b};
else
fun1 dir${a};
fi
let a--;
done
```

```
read -p "input: " answer
while [[ "$answer" != "ds" ]]
do
echo "error, retry";
read -p "input: " answer
done
```

until
until 命令
do
...
done

```
until [ -e /var/lib/mysql/mysql.sock ] 
#若/var/lib/mysql/mysql.sock文件不存在, 则说明mysqld服务未启动
do
/etc/init.d/mysqld start
done


until [ -z $1 ] #$# -gt 0
do
echo "there are $# parameters: $*";
shift; #shift的使用
done


a=3;
until [ $a -lt 0 ]
do
echo $a;
a=$[ $a - 1 ];
done
```

循环监控网站的index.html, 如果访问不到页面, 则停止30秒, 继续测试
```
until wget -q http://192.168.10.8/index.html
do
sleep 30;
done
echo ok;
exit 0;
```


case语句
```
a=0;
case $a in
[012]) echo aa;;
3|4|5) echo bb;;
[a-z]|[A-Z]) echo cc;;
*) echo dd;;
esac
```


select语句: 选择时选择序号
```
select var in 'linux' 'unix' 'macos' 'windows'
do
break;
done
echo "you select is $var";
```

select常与case一起使用
```
PS3="please select: "
select var in 'linux' 'unix' 'macos' 'windows' 'quit'
do
case $var in
linux) echo "aa";;
unix)  echo "bb";;
quit)  exit 0;;
*)     echo "wrong";;
esac
done
```

函数(function)
在Shell中, 函数就是一组命令或语句, 形成一个可用块
函数由两部分组成:
函数名(在一个脚本中必须唯一)
函数体(命令或语句集合)


给函数传值, 直接接收$1、$2等, 方法与脚本接收参数是一样的, 可以用$@ $#等!
传1个就用$1, 传多个则用for i in "$@"更好!
```
function checkRPM()
{
for i in "$@"
do
! rpm -q $i && yum install $i -y
done 
} &> /dev/null
checkRPM httpd mysql-server php gd
```


递归调用:
```
#!/bin/bash
#comment
judge_ip()
{
if [[ "$1" =~ "abc" ]] #包含有abc
then
echo 'ok';
else
echo -n 'error, input: ';
read ip
judge_ip "$ip";
fi
}
judge_ip "$1"


a=100
fun1()
{
echo $a;
#local b; 加与不加这行来看结果
b=200; #或local b=200
}
fun1
echo $b;
```

```
引用另一个文件:
lib.sh文件 #在lib.sh中写很多公共函数
fun1()
{
date;
}

test.sh文件

#!/bin/bash
. lib.sh #在test.sh中, .一下或source一下即引用了lib.sh文件, 然后就可以用里面的函数了
fun1


fun1() #先定义好, 后调用
{
if rpm -q gcc &> /dev/null
then
return 0;
else
return 1;
fi
}
if fun1
...


fun1()
{
rpm -q gcc &> /dev/null;
date;
lsls;
#无显式return时, 最后一条命令的$?即是返回值
return; 
#return后没接数值, 也是最后一条命令的$?即是返回值 
}
fun1
...


fun1()
{
echo "$1";
echo "$2";
}
fun1 abc xyz #fun1 $1 $2, 给函数传参数
```

expect


expect这个名字准确说明了它的作用, 即"期待"交互式程序的输出 
然后发送给该程序一些输入作为响应
expect使用Tcl, 是Tcl脚本语言的扩展
它的目的是与交互式程序进行通信


在shell脚本中使用expect的方法, 一般是调用(执行)另写好的expect文件如:
```
#!/bin/bash
#comment
./test2.exp &> /dev/null
expect -f test2.exp &> /dev/null
```

yum install expect


```
vim test.exp
#!/usr/bin/expect -f
#comment
spawn passwd tom
expect "*password:*"
send "123456\r"
expect "*password:*"
send "123456\r"
expect eof

执行方法:
chmod +x test.exp
./test.exp

expect -f test.exp



#!/usr/bin/expect -f
#comment
spawn yum install httpd
expect "*y/N*"
send "y\r"
expect eof



#!/usr/bin/expect -f
#comment
if { $argc != 3 } { 
    puts "Usage $argv0 ..."
    exit 1 
  } 
set ip [lindex $argv 0]
set un [lindex $argv 1]
set pa [lindex $argv 2]
spawn ftp $ip
expect "*Name*"
send "$un\r"
expect "*Password:*"
send "$pa\r"
expect "*ftp>*"
send "get file1\r"
expect "*ftp>*"
send "quit\r"
expect eof

./text.exp 192.168.6.6 tom 123456 #在命令行传3个参数进去



#!/usr/bin/expect -f
#comment
set ip [lindex $argv 0]
set pa [lindex $argv 1]
spawn ssh root@$ip
expect "*yes/no*" {send "yes\r"; expect "*password*" {send "$pa\r"}} \
           "*password*" {send "$pa\r"}
#expect "*abc*" {send "def\r"} "*xyz*" {send "123\r"} 若匹配abc则执行什么, 若匹配xyz则执行什么
expect eof

执行: ./test.exp 192.168.6.6 aixocm
```

屏幕上有输出, 怎样去掉? 放入bash脚本中&> /dev/null

在bash脚本中调用expect文件:
```
#!/bin/bash
#comment
expect -f test2.exp &> /dev/null
./test2.exp &> /dev/null
echo $?
```

带颜色的输出
```
echo -e "\033[37;44;1mhello\033[0m world"
echo -e "\033[41mhello\033[0m world" #这样也可, 并不必要3个值, 仅设个背景色即可
echo -e "\033[31mhello\033[0m world" #这样也可, 并不必要3个值, 仅设个前景色即可

\033[引导非常规字符序列37;44;1前后顺序没有关系m意味着设置属性然后结束非常规字符序列
hello
\033[引导非常规字符序列0设置属性到默认设置m意味着设置属性然后结束非常规字符序列
world
前景 红31 蓝34 白37
背景 红41    蓝44白47
1表示设置粗体(无明显效果)
```

dialog

rpm -q dialog

每种对话框的输出或叫返回有两种:
一种: 使用退出状态码($?), "OK"为0, "Cancle"和"NO"均为1
另一种: 使用STDERR(2>)
```
a='abc'
b='xyz'
dialog --title "$a title" --msgbox "$b welcome" 15 50; 
dialog --title "title" --infobox "thanks" 15 50; 
sleep 3; 
dialog --clear

dialog --title "title" --yesno "are you sure" 15 50
[ $? -eq 0 ]

dialog --title "title" --inputbox "please:" 15 50 2> file1
var1=$( cat file1 )

dialog --title "title" --menu "hi, $var1" 15 50 4 \
"v1" "v11" "v2" "v22" "v3" "v33" "v4" "v44" 2> file1
var2=$( cat file1 )

dialog --title "title1" --yesno "Welcome me.\n\nAre you continue?" 15 50
#$?


dialog --clear --title "title" --checklist "pick a option" 15 50 3 \ 
rh "release is redaht" on \
suse "release is suse" off \
ubutu "release is ubutu" off 2> file1
cat file1



dialog --clear --title "title" --nocancel --radiolist "t1\nt2\nt3\nt4" 15 50 3 \
"128" "128M memory" on \
"256" "256M memory" off \
"512" "512M memory" off 2> file1
a=`cat file1`



dialog --title "copying file" --gauge "abc" 15 50;


i=0;
while (( i <= 100 ))
do
echo "XXX";
echo $i;
echo "a1..."
echo "a2..."
echo "a3..."
echo "XXX";
(( i++ )) #(( i+=5 ))
sleep 0.1 #必要
done | dialog --title "title" --gauge "abc" 15 50;


dialog --title "title" --form "abc" 10 30 7 
"ip:" 1 1 "" 1 5 20 0
     ip:在第几行 
"nm:" 2 1 "" 2 5 20 0
       ip:与左边线之间的距离
"gw:" 3 1 "gway" 3 5 20 0
          文本框中默认值 
"ns:" 4 1 "" 4 5 20 0
            文本框在第几行
"xx:" 5 1 "" 5 5 20 0
  文本框与左边xx:之间的距离
"yy:" 6 1 "" 6 5 20 0
文本框的宽度
"zz:" 7 1 "" 7 5 20 0
文本框中可以输入的字符的宽度(个数), 若为0则等于前面的文本框的长度20}t$" fstab
```


Regular Expression

正则得从编译原理里面的正规式说起了. 太酷了.
```
grep sed awk vim均实现了正则表达式
如 cat /etc/passwd | grep "^[A-Z]"


匹配email地址
grep -E "[a-Z0-9.]+@[a-Z0-9.]+\.[a-Z]{2,3}" file1
匹配HTTP URL
grep -E "http://[a-Z0-9.]+\.[a-Z]{2,3}" file1


正则表达式的元字符
/^love/


/love$/


/l..e/ #单个任意字符(换行符\n除外), 有且仅有一个


/abc* #ab后接0个或多个c


/o*ve #*将前面的那一个字符o重复0次或多次


/[Ll]ove #有且仅取1个


/[a-z]ove


/[A-Z]ove


/[^a-z]ove


/ove[^a-zA-Z0-9]


/love\. #love.


/\<bin\> #单词匹配, sbin不会匹配


/\(lov\)aa\1er #标签, lovaalover


:1,$ s/\([Aa]bc\)yz/\1xyz/g


:1,$ s/\(abc\) and \(xyz\)/\2 and \1/g 


/abco\{5\} #字符o连续出现5次


/abcx\{2\}y\{3\} #x重复2次, y重复3次


/abco\{5,\} #字符o连续出现至少5次


/abco\{5,10\} #字符o连续出现5到10次


/oo.* #oo后接任意字符串.*, 假如有一行以oo开头, 则这一行均匹配


以b或f或m开头的行 /^[bfm]
不是以小写字母开头的行 /^[^a-z]
/\<f.*th\>


bash提供的通配符与正则元字符的区别:
ls *.h
ls | grep "*.h"
ls | grep ".*\.h"
```

POSIX类字符集
/[[:digit:]] #数字
/[[:upper:]] #大写字母
grep -n "^[[:lower:]]" file1 #小写字母开头


grep的使用
global search regular expression(RE) and print out the line
Unix的grep家族包括grep、egrep和fgrep

```
grep "root" /etc/passwd -c #有多少行匹配
grep "root" /etc/passwd -n
grep "root" /etc/passwd /etc/shadow -h
cat /etc/grub.conf | grep -v "^#"
grep -n "^$" file1 #空白行
cat file1.sh | grep -v "^\s*$"
pstree | grep -A 2 -B 2 bash


grep支持的扩展的正则表达式元字符
grep "root|ftp" /etc/passwd -E
grep root\|ftp /etc/passwd -E


egrep "^ro{2,5}t$" fstab
egrep "^ro{2}t$" fstab
egrep "^ro{2,}t$" fstab
```

1. seq

```
seq 4 #seq 1 4, 默认从1开始, 所以可省略1
seq 3 6
seq -3 3
seq -w 10 #等宽输出, 与位数最多的对齐
```

2. tr
tr是单个字符处理工具, 而不是字符串处理工具

```
  替换:
1、将文件file中出现的"abc"替换为"xyz"
  cat file | tr "abc" "xyz" > new_file
  凡是在file中出现的"a"字母, 都替换成"x"字母
              "b"字母替换为"y"字母
  "c"字母替换为"z"字母
而不是将字符串"abc"替换为字符串"xyz"
 
2、使用tr命令"统一"字母大小写
cat file | tr "a-z" "A-Z" > new_file
cat file | tr "A-Z" "a-z" > new_file
 
3、把文件中的数字0-9替换为a-j
cat file | tr "0-9" "a-j" > new_file


4、制表符\011 空格符\040    
cat file | tr "\011" "\040" > new_file
 
5、冒号":"替换成换行符"\n"
  echo $PATH | tr ":" "\n"



删除:
6、删除文件file中出现的"snail"字符
  cat file | tr -d "snail" > new_file
  凡是在file文件中出现的's','n','a','i','l'字符都会被删除, 而不是仅删除出现的"snail"字符串
 
7、删除文件file中出现的换行'\n'、制表'\t'字符
  cat file | tr -d "\n\t" > new_file
  不可见字符都得用转义字符来表示的, 这个都是统一的
  
8、删除"连续着的"重复字母, 压缩成第一个
  cat file | tr -s "a-zA-Z" > new_file
  echo "a b  c   d    e" | tr -s " " #把空格压缩成1个

9、删除空行
  cat file | tr -s "\n" > new_file
  
10、删除Windows文件"造成"的'^M'字符
  cat file | tr -d "\r" > new_file
或者
cat file | tr -s "\r" "\n" > new_file
  这里-s后面是两个参数"\r"和"\n", 用后者替换前者
  
替换或删除
echo "12M" | tr -d "M" #删掉M, 输出12, 太帅了!
tr -d " " #删掉空格

echo "12abcXYZ" | tr -d "a-zA-Z" 

echo "aaabbbccc" | tr -s "a-z" #将重复的小写字母压缩为1个, abc
echo "aaaBBB999" | tr -s "a-zA-Z0-9" #将重复的大小写字母或数字均压缩为1个, aB9
echo "a       b" | tr -s " " #将重复的的空格压缩为1个

echo "abc" | tr "a-z" "A-Z" #小写替换成大写
```

3. sort
```
对行进行排序, 默认字段分隔符是空白(与awk一样)
sort -t: /etc/passwd #-t指定字段分隔符
sort -t: -k3 /etc/passwd #-k3: 以第3个字段排序, 默认以第1个字段排序
sort -t: -k3n /etc/passwd #n表示数值
sort -t: -k3nr /etc/passwd #r表示反向
```

4. uniq
```
先sort再uniq:
111
111
222
111

去掉重复行
vim file1
111
111
111
222
222
333


uniq -u file1 #只打印唯一的行


uniq -c file1 #将每行重复出现的次数打印在行首
3 111
2 222
1 333
```

5. cut
默认字段分隔符为tab, 不是空白, 所以不好控制
cut -d " " -f 2 #指定字段分隔符为1个空格, 打印第2列 

6. sed
```
\s任意的空白符, 包括空格、制表符(tab)、换行符、中文全角空格 
\s空白字符: [ \t\n\x0B\f\r]
\t 制表符(tab) ('\u0009')  
\n 新行, 换行符 ('\u000A')  
\r 回车符 ('\u000D')  
\f 换页符 ('\u000C')  
\a 报警 (bell) 符 ('\u0007')  
\e 转义符 ('\u001B')  
\cx 对应于x的控制符  

sed -i '/^\s*security = user/s/user/share/' smb.conf
sed -n '/^\s*security = user/p' smb.conf
sed -i 's/^\s*security =.*/\tsecurity = share/' smb.conf
sed -i 's/.*hosts allow.*/\thosts allow = 127. 192.168.0.0\/16/' smb.conf
sed -i '/hosts allow/s/^.*$/\thosts allow = 127. 192.168.0.0\/16/' smb.conf

stream editor, 完美地配合正则使用, 主要进行文本替换 
sed [options] 'command' file[s]
定位(址)
sed -n '1p' file1
sed -n '$p' file1 #最后一行
sed '2,4p' file1
sed -n '2,4p' file1
sed -n '2,+4p' file1
sed -n '1p;4p;7p' file1 #只打印第1 4 7这3行
sed '1s/abc/YYY/; 4s/abc/YYY/' file1

sed支持的基本正则
sed -n '/^root/p' file1
sed -n '/^[^0-9]/p' file1
sed -n '/r..t/p' file1

sed支持的扩展正则
sed -rn '/roo?t/p' file1 #扩展正则, o?, 0个或1个
sed -rn '/roo+t/p' file1 #扩展正则, o+, 1个或多个
grep -E "[a-Z0-9.]+@[a-Z0-9.]+\.[a-Z]{2,3}" file1

sed函数的使用
a
i
c
d 删除
r
w

sed '/localhost/a ds.com ftp' file1 #a, 先匹配localhost, 然后在其后插入新行 ds.com ftp
sed '/localhost/r /etc/file2' file1 #r, 读取另一文件的内容
sed '4r file2' file1
sed -n '/aixocm/w file2' file1 #w另存为, file2的内容被覆盖
sed '/root/c aixocm' file1 #先匹配root, 将整个这一行替换成aixocm
sed '/127/d' file1
sed '/tom/d' file1
sed '/tom/!d' file1
sed '3d' file1
sed '1,3d' file1
sed '3,$d' file1
sed '$a AAA=XYZ' file1 #在file1末行后加一行AAA=XYZ
cat file1 | sed '/^$/d'
sed -e '1,3d' -e 's/word1/word2/g' file1

引用变量
var="root"
sed "/$var/c aixocm" file1 #换成""即可

text="hello"
echo "hello world" | sed "s/$text/HELLO/"

另一种替换:
sed 's/root/ROOT/' file1
sed 's/root/ROOT/g' file1
sed 's/root/ROOT/2' file1
sed '/word1/s/word2/word3/g' file1
cat file1 | sed 's/pattern/replace_string/' #从stdin中读取输入

sed 's/text/replace/' file1 > newfile
mv newfile file1

sed -i 's/text/replace/' file1

echo "this thisthisthis" | sed 's/this/THIS/'
echo "this thisthisthis" | sed 's/this/THIS/g'
echo "this thisthisthis" | sed 's/this/THIS/3g'

echo "a b c" | sed 's/ //g'

/在sed中作为定界符, 可使用任意的定界符如:
sed 's:text:replace:' file1 #不推荐

echo "ab/c def" | sed 's/ab\/c/xxx/' #要将/转义\/

sed '/^$/d' file1 #直接回车产生的空白行
sed '/^\s*$/d' file1 #若这行中有空格或tab, \s表示空白

echo "this is an example" | sed -r 's/\w+/[&]/g' #匹配一个单词
echo "this is an example" | sed -r 's/[a-Z]+/[&]/g' #匹配一个单词 

若用了-n, 就要用p, 不然没有显示

sed '1,$ s/root/ROOT/g' file1 #1,$不要也可, 默认即所有行
sed '2 s/root/ROOT/g' file1 #只替换第2行的root->ROOT
sed -i '2,4 s/.*/abcdefg/' file1 #用abcdefg替换file1中2到4行

去行首#
sed '/ADDR/s/^#//' file1

行首加#
sed '/ADDR/s/^/#/' file1
ls -l | sed 's/^/ /'
ls -l | sed 's/^/\t/'

多次替换
sed 's/localhost/WWW/' file1 | sed 's/127/001/'
sed -e 's/localhost/www/' -e 's/127/001/' file1
sed 's/localhost/www/; s/127/001/' file1 #组合多个表达式

sed标签(子串匹配), 第1个子串\1, 第2个子串\2
sed 's/\(root\)/\1_aixocm/g' file1
sed -r 's/(root)/\1_aixocm/g' file1
sed -r 's/(root)/&_aixocm/g' file1


echo "this is digit 7 in a number" | sed -r 's/digit ([0-9])/\1/'
echo "seven eight" | sed 's/([a-Z]+)([a-Z]+)/\2 \1/'

范围匹配
sed '/abc/,/xyz/s/aixocm/YYY/' file1 #将abc与xyz之间的aixocm -> YYY, 其它地方的aixocm不会
sed '/abc/,/xyz/s/aixocm.*/YYY/' file1
sed '/abc/,/xyz/s/.*aixocm/YYY/' file1
sed '/abc/,/xyz/s/.*aixocm.*/YYY/' file1 #包含有aixocm的整行被替换

sed -n '/abc/,/xyz/p' file1

sed改配置文件:
sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux
sed -i '/UseDNS/s/^.*$/UseDNS no/' /etc/ssh/sshd_config

sed -n '/ext4/p' /etc/fstab
sed '/ext4/d' /etc/fstab
sed '/^#/d' file1
sed -e 's/old/new/g' -e 's/[0-9]$/&.yyy/' file1
```

7. awk

是gawk的符号链接, 3位作者的名字的首字母(man awk), 是一门编程语言, 灵活性是awk最大的优势

awk 'BEGIN{commands}pattern {commands}END{commands}' file1

BEGIN语句块可选, pattern语句块可选, {}语句块可选, END语句块可选

就像一个用来读取行的while循环, 从第一行读至最后一行, 每读一行, 先检查该行与pattern是否匹配, 若匹配,则执行{}中的语句, 然后再读取下一行

工作原理:

1. 执行BEGIN{commands}语句块中的语句

2. 从文件或stdin中读取第1行, 然后执行pattern {commands}, 重复这个过程, 直到所有行被读取完毕

3. 执行END{commands}语句块中的语句

默认以空白作为字段分隔符

基本结构:

awk 'BEGIN{commands}pattern {commands}END{commands}' file1

awk 'BEGIN{print "start..."}{print $1}END{print "end..."}' file1

awk 'BEGIN{i=0}{i++}END{print i}' file1 #文件总行数, 改为""双引号也可


awk的基本介绍

与sed一样, 均是一行一行的读取、处理, sed作用于一整行的处理, 而awk将一行分成数个字段来处理, 默认的字段分隔符为空白
```
vim file1
abc def:hij:123:456:xyz:789
awk -F "[ :]" '{print $1, $2}' file1
输出abc def
```
字段分隔符是正则, 用""引起正则[ :], 防止shell将它解释成shell的元字符

以空格或:作为字段分隔符, 空格与:一样均为分隔符(:就是空格!)

```
tom  savege  100
molly  lee  20
john  doe  300
awk '{print $1, $3}' file1
head -l /etc/passwd | cut -d ":" -f 1-3 #与cut对比一下 -f 1,3,5
取网关、IP地址

ifconfig -a | grep "^\w" | awk '!/lo/{print $1}'


echo | awk '{var1="abc"; var2="ijk"; var3=100; print var1, var2, var3}'
echo | awk '{var1="abc"; var2="ijk"; var3=100; print var1 var2 var3}'
echo | awk '{var1="abc"; var2="ijk"; var3=100; print var1 "---" var2 "---" var3}'

awk -F: '{print NR, NF, $1, $NF, $(NF-1)}' /etc/passwd

awk -F ":" '{print $1, "lines=" NR, "columns=" NF}' /etc/passwd

awk -F: 'NR==2{print $1}' /etc/passwd


统计文件的行数:
awk 'END{print NR}' file1

seq 5 | awk 'BEGIN{sum=0; print "sum:"}{print $1"+"; sum+=$1}END{print "="; print sum}'
seq 5 | awk '{sum+=$1}END{print sum}'

将外部变量传给awk:
var=100
echo | awk -v v1=$var '{print v1}'

var1=10; var2=20
echo | awk '{print v1, v2}' v1=$var1 v2=$var2 #输入来自stdin
awk '{print v1, v2}' v1=$var1 v2=$var2 file1 #输入来自file

行过滤:
awk -F: 'NR==2{print $1}' /etc/passwd
awk -F: 'NR==2,NR==4{print $1}' /etc/passwd #2至4行
awk -F: 'NR==2 || NR==4{print $1}' /etc/passwd #第2行和第4行
awk -F: 'NR<5{print $1}' /etc/passwd
awk -F: 'NR<=5{print $1}' /etc/passwd

整行与正则匹配
awk -F: '/root/{print $1}' /etc/passwd
awk -F: '/^root/{print $1}' /etc/passwd
awk -F: '!/root/{print $1}' /etc/passwd
awk -F: '$0 ~ /root/{print $1}' /etc/passwd #相当于这样

另一种写法: 打印匹配行
awk '/root/' /etc/passwd
awk '/^root/' /etc/passwd

字段与正则匹配
awk -F: '$7 !~ /bash/{print $1}' /etc/passwd #~匹配 !~不匹配

设置字段定界符:
awk -F: '{print $1}' /etc/passwd
awk 'BEGIN{FS=":"; OFS="---"}{print $1, $NF}' /etc/passwd

awk -F: 'OFS="---"{print $1, $3}' /etc/passwd

awk -F: 'BEGIN{OFS="---"}NR==2{print $1, $3}' /etc/passwwd

awk 'BEGIN{FS=":"; OFS="---"}NR==2{print $1, $3}' /etc/passwd

awk -F: '$1=="root"{print $0}' /etc/passwd
a=root
awk -F: -v var=$a  '$1==var{print $0}' /etc/passwd
```

流程控制
if
```
awk -F: '{if($1=="root") print $1}' /etc/passwd
awk -F: '{if($1=="root") {print $1; print $6}}' /etc/passwd
awk -F: '{if($1=="root") print $1; else print $6}' /etc/passwd
awk -F: '{if($1=="root") print $1; else if($1=="ftp") print $2; else if($1=="mail") print $3; else print NR}' /etc/passwd
awk -F: '{var=($3>=500)?$1:"sys"; print $1 "\t" $3 "\t" var}' /etc/passwd
awk -F: '{if($3==0) print $1, "admin"; else if($3>0 && $3<500) print $1, "sys"; else print $1, "user"}' /etc/passwd
```

BEGIN END的使用
```
awk -F: 'BEGIN{i=0}{i++}END{print i}' /etc/passwd
awk -F: 'BEGIN{print NR, NF}' /etc/passwd #读前处理
awk -F: 'END{print NR, NF}' /etc/passwd #读后处理
awk -F: 'BEGIN{i=0}{i+=NF}END{print i}' /etc/passwd
awk -F: 'BEGIN{i=0}$3>=500{print $1; i++}END{print i}' /etc/passwd #显示所有普通用户及其个数
```

break
continue
next #读取下一行
exit #不再读取下一行, 读取动作终止, 转为执行end语句块
```
awk 'BEGIN{for(x=1;x<=5;x++){if(x==3) break; print x}}' #continue

awk -F: '{if(NR>3) next; print $1}END{print NR}' /etc/passwd
awk -F: '{if(NR>3) exit; print $1}END{print NR}' /etc/passwd
```

循环语句
for
```
awk 'BEGIN{for(x=1; x<=5; x++) print x}'
awk 'BEGIN{for(i=1;i<=3;i++){for(j=1;j<=5;j++) print i, j}}'
awk -F: '{for(x=NF;x>0;x--) print $x}' /etc/passwd
awk -F: '/bash$/{for(x=NF;x>0;x--) printf "%-13s", $x; printf "\n"}' /etc/passwd
```

while
```
awk -F: '{while($3<3){print $3, $1; $3++}}' /etc/passwd
awk 'BEGIN{i=1; while(i<10){if(i%2==0)print i; i++}}'
```


awk中的函数
```
awk 'BEGIN{print int(3.14159)}' #取整数部分
awk 'BEGIN{x="abcdefg"; print substr(x, 4, 3)}'
awk 'BEGIN{x="abcdefg"; print substr(x, 4)}'

awk 'BEGIN{x="abcdefg"; print length(x)}'
awk 'NR==2{print length($0)}' /etc/passwd #把$0省略也可
awk 'BEGIN{x="abcdefg"; print substr(x, length(x), 1)}'

a="abcdefg"
var=`echo $a | awk '{print substr($0, length($0), 1)}'`

awk 'BEGIN{x="xyzabcxyzabcxyzabc"; sub("abc", "ABC", x); print x}' #sub()改用gsub()

awk读取命令输出(getline, 取得1行)
awk 'BEGIN{print "Enter number: "; getline NUM; for(i=1;i<=NUM;i++) print i}'
awk 'BEGIN{"uname -a" | getline; print $3}'
awk -F: 'BEGIN{while(getline < "/etc/passwd") print $3 "\t" $1}'

echo | awk -F: '{"grep root /etc/passwd" | getline; print $0}' #或打印$1
echo | awk '{"date" | getline; print $0}'
```


awk字符串拼接(字符串转数字, 数字转字符串) 
awk中数据类型是不需要定义的, 是自适应的, 有时候需要强制转换, 我们可以通过下面操作完成


拼接
```
awk 'BEGIN{a=100;b=100;c=a""b; print c}'      
100100
awk 'BEGIN{a="aa";b="bb";c=a""b; print c}'      
aabb


awk 'BEGIN{a="a";b="b";c=(a+b);print c}'  
0
+号操作符强制将左右两边的值转为数字类型, 然后进行操作
```


在awk中使用循环:
```
echo | awk '{for(i=0; i<=10; i++) print i}'
```

awk中的数组:
```
echo | awk '{arr["a"]="aa"; arr["b"]="bb"; arr["c"]="cc"; for(i in arr) print i, arr[i]}'
生成数组
vim file1
111
222
333
444
555
666
awk '{arr[x++]=$1}END{for(i=0;i<NR;i++)print arr[i]}' file1
```
