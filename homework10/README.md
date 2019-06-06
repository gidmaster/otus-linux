# HW10

## Get Started

1. Get `vagrant`.
2. Get `git`.
3. Run VM
    ```bash
    vagrant up
    ```
4. Connect to `dc` and run command:
```bash
vagrant ssh dc
kinit admin && ipa user-add --first="Ivan" --last="Ivanov" --cn="Ivan Ivanov" --password ivanov --shell="/bin/bash"
```
5. Connect to `hw10` and check that is possible to login with user:
```bash
vagrant ssh hw10
sudo -l ivanov
```