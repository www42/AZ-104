$ip = '172.211.156.40'
for ($i = 1; $i -le 10; $i++) {
    Invoke-WebRequest -DisableKeepAlive -Uri $ip | % Content
}
