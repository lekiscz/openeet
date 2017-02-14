# stunnel to access EET endpoint

For sources see [stunnel original distribution including sources](https://www.stunnel.org/)

For stunnel licensing see LICENSE.md.

This is a subset of official stunnel distribution preconfigured to create tunnel to eet
endpoint to handle TLS 1.1 requirement on older systems.

To start tunnel in console window run:

```
tstunnel eet.conf
```

To start tunnel in background run:

```
stunnel -quiet eet.conf
```

To run tunnel as a service run (admin privs needed) following command to install a service:

```
stunnel -install eet.conf
```

then start the service (admin privs needed) with:

```
stunnel -start
```

use netstat to check if the service listens:

```
netstat -a -o -n 
```

and in the output you should see lines like this (ports depend on your config, PID will differ)

```
 TCP    127.0.0.1:27541        0.0.0.0:0              LISTENING       4144
 TCP    127.0.0.1:27542        0.0.0.0:0              LISTENING       4144
```

When stunnel is running you can access:

* EET Playground endpoint at `http://localhost:27541/eet/services/EETServiceSOAP/v2`
* EET Production endpoint at `http://localhost:27542/eet/services/EETServiceSOAP/v2`

The port numbers in those URLs depend on "accept" lines in `eet.conf`.
