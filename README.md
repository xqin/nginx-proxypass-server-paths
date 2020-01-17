
# Understanding Nginx proxy_pass and url path translations

Ref: https://tarunlalwani.com/post/nginx-proxypass-server-paths/


# Proxy Pass and Paths

| Case # | Nginx location | proxy_pass URL | Test URL | Path received |
| ------ | -------------- | -------------- | -------- | ------------- |
| 01 | /test01 | http://127.0.0.1:8080 | /test01/abc/test | /test01/abc/test|
| 02 | /test02 | http://127.0.0.1:8080/ | /test02/abc/test | //abc/test|
| 03 | /test03/ | http://127.0.0.1:8080 | /test03/abc/test | /test03/abc/test|
| 04 | /test04/ | http://127.0.0.1:8080/ | /test04/abc/test | /abc/test|
| 05 | /test05 | http://127.0.0.1:8080/app1 | /test05/abc/test | /app1/abc/test|
| 06 | /test06 | http://127.0.0.1:8080/app1/ | /test06/abc/test | /app1//abc/test|
| 07 | /test07/ | http://127.0.0.1:8080/app1 | /test07/abc/test | /app1abc/test|
| 08 | /test08/ | http://127.0.0.1:8080/app1/ | /test08/abc/test | /app1/abc/test|
| 09 | / | http://127.0.0.1:8080 | /test09/abc/test | /test09/abc/test|
| 10 | / | http://127.0.0.1:8080/ | /test10/abc/test | /test10/abc/test|
| 11 | / | http://127.0.0.1:8080/app1 | /test11/abc/test | /app1test11/abc/test|
| 12 | / | http://127.0.0.1:8080/app2/ | /test12/abc/test | /app2/test12/abc/test|


# Run

```
docker-compose up --build
```


# Output

```
nginx_1  | Case #   Test URL             $host    $request_uri           $uri
   nx_1  |   01     /test01/abc/test     1.com    /test01/abc/test       /test01/abc/test
             02     /test02/abc/test     2.com    //abc/test             /abc/test
   nx_1  |   03     /test03/abc/test     3.com    /test03/abc/test       /test03/abc/test
             04     /test04/abc/test     4.com    /abc/test              /abc/test
     _1  |   05     /test05/abc/test     5.com    /app1/abc/test         /app1/abc/test
     _1  |   06     /test06/abc/test     6.com    /app1//abc/test        /app1/abc/test
      1  |   07     /test07/abc/test     7.com    /app1abc/test          /app1abc/test
     _1  |   08     /test08/abc/test     8.com    /app1/abc/test         /app1/abc/test
   nx_1  |   09     /test09/abc/test     a.com    /test09/abc/test       /test09/abc/test
   nx_1  |   10     /test10/abc/test     b.com    /test10/abc/test       /test10/abc/test
nginx_1  |   11     /test11/abc/test     c.com    /app1test11/abc/test   /app1test11/abc/test
nginx_1  |   12     /test12/abc/test     d.com    /app2/test12/abc/test  /app2/test12/abc/test
```
