### Summary of Configuration Steps

1. **Installation**: Installed `nginx` on the LBR server.
2. **Discovery**: Verified Apache is running on App Servers via port **3000** (as per your `ss` output).
3. **Editing**: Updated the `http` block in `/etc/nginx/nginx.conf` with the `upstream` and `server` directives.
4. **Deployment**: Validated the syntax (`nginx -t`) and restarted the service.

---

### Configuration Breakdown

#### 1. The `upstream` Block

```nginx
upstream nautilus_app {
    server 172.16.238.10:3000;
    server 172.16.238.11:3000;
    server 172.16.238.12:3000;
}

```

* **Purpose**: Defines a group of backend servers.
* **Logic**: Nginx treats these three IPs as a single pool named `nautilus_app`. By default, it uses **Round Robin** to distribute traffic equally.

#### 2. The `server` Block

```nginx
server {
    listen 80;
    server_name stlb01.stratos.xfusioncorp.com;
}

```

* **listen 80**: Tells Nginx to listen for incoming web traffic on the standard HTTP port.
* **server_name**: The domain or hostname Nginx responds to.

#### 3. The `location` and `proxy` Directives

```nginx
location / {
    proxy_pass http://nautilus_app;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
}

```

* **location /**: Catches all requests starting from the root URL.
* **proxy_pass**: Forwards the request to the `upstream` pool defined earlier.
* **proxy_set_header**: These ensure the backend Apache servers "see" the original client's IP address and requested Host header, rather than seeing everything as coming from the Load Balancer.
