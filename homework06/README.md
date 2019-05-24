# HW06

## Get Started

1. Get `vagrant`.
2. Get `git`.
3. Run VM
    ```bash
    vagrant up
    ```

## Task 1.

**Write service. Service should monitor into log file and look for `<key word>` every 30 seconds. Log file and word should be in `/etc/sysconfig`.**

1. [Scripts](scripts/monitor)
2. Check results.
    ```bash
    echo "access" > ~/log.log

    systemctl status monitor.service
    systemctl status monitor.timer

    sleep 30

    journalctl -u monitor.service
    ```

## Task 2.

**Install `spawn-fgci` from `epel` and re-write init-file to unit-file. The service name should be the same.**

1. [Scripts](scripts/fastcgi)
2. Check results.
    ```bash
    systemctl status spawn-fcgi.service
    curl localhost
    ```
## Task 3.

**Update apache(httpd) unit-file to run multi-instances with diffirent configurations.**

1. [Scripts](scripts/apache)
2. Check results.
    ```bash
    systemctl status httpd@httpd1.service
    systemctl status httpd@httpd2.service
    ```
    ```bash
    curl localhost:8000
    curl localhost:8001
    ```
