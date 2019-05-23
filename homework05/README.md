# HW05

## Get Started

1. Get `vagrant`.
2. Get `git`.
3. Set your email, the number of top ips, the number of top urls in `config.ini`

4. Run VM
    ```bash
    vagrant up
    ```

5. Check your email (email will come within an hour)

6. To send email right now:
    ```bash
    vagrant ssh -c 'sudo run-parts /etc/cron.hourly'
    ```