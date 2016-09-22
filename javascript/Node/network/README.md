## TCP SERVER
```
shell>node tcp_server.js
Server ing...
Connection closed.
```

## TCP CLIENT
```
shell>telnet 127.0.0.1 8866
shell>nc -U /tmp/echoo.sock

shell>node tcp_client.js
client connected
Welcome this example:
Hello
client disconneted

```
