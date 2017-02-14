# Stunnel for EET endpoints

For sources see [stunnel website](https://stunnel.org/).

For stunnel licensing see LICENSE.md.

This is a subset of official stunnel distribution preconfigured to create tunnel to EET
endpoints to handle TLS 1.1 requirement on older systems.

To start tunnel in console window run:

```
tstunnel.exe eet.conf
```

To install and run tunnel as a Windows service run (admin privs needed, start it by using
the context menu and Run as Administrator menu item):

```
install.cmd
```

It will install the Windows service by using [NSSM tool](http://nssm.cc) and start it.

Use netstat to check if the service listens:

```
netstat.exe -a -o -n | findstr.exe "LISTENING" | findstr.exe "127.0.0.1" | findstr.exe ":2754"
```

In the output you should see lines like this:

```
 TCP    127.0.0.1:27541        0.0.0.0:0              LISTENING       xxxx
 TCP    127.0.0.1:27542        0.0.0.0:0              LISTENING       xxxx
```

When the tunnel is running you can access:

* EET Playground endpoint at `http://localhost:27541/eet/services/EETServiceSOAP/v2`
* EET Production endpoint at `http://localhost:27542/eet/services/EETServiceSOAP/v2`
