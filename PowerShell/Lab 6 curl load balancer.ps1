$ip = '51.8.57.184'
for ($i = 1; $i -le 10; $i++) {
    Invoke-WebRequest -DisableKeepAlive -Uri $ip | % Content
}
