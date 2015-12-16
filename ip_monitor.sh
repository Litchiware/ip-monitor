hostname=$(hostname)
record="$hostname $(ip a show enp3s0 | grep 'inet ' | xargs | cut -f2 -d ' ')"
cd /home/litchiware/apps/scripts/ip-monitor
record_old=$(grep "$hostname" ips)
if [[ $record = $record_old ]]; then
  exit 0
fi
ping -c1 -W1 www.baidu.com
if [[ "$?" -ne 0 ]]; then
  curl 'http://net.tsinghua.edu.cn/do_login.php' --data 'action=login&username=xb15&password={MD5_HEX}5894a528171580d4d35e23b1d9ed8879&ac_id=1'
fi
git pull origin master
sed -i "s:^$hostname.*$:$record:g" ips
git commit -a -m "$hostname: $(date)"
git push origin master
