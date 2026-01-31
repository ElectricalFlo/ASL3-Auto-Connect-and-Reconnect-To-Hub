

Auto-connect and auto-reconnect helper for AllStarLink / ASL3 nodes.

## Install


All configuration is done **locally on your ASL3 node after installation**.

---

## 🔄 What actually happens (step by step)

### 1️⃣ Clone and install (run on your ASL3 node)
```bash
git clone https://github.com/N2CFX/ASL3-Auto-Connect-and-Reconnect-To-Hub.git
cd ASL3-Auto-Connect-and-Reconnect-To-Hub
sudo bash install.sh

````
This does the following:

Installs the auto-link script

Installs the systemd service

Creates a local config file at /etc/asl3-autolink.conf

⚠️ At this point, nothing is configured yet.

2️⃣ Edit your local configuration file

Now configure it on your node:
````bash
sudo nano /etc/asl3-autolink.conf
````
You will see something like:

LOCAL_NODE="681970"
TARGET_NODE="12345"
CONNECT_CODE="*3"
Change the values to match your own node numbers, for example:

LOCAL_NODE="YOUR NODE NUMBER"
TARGET_NODE="THE HUB YOU WANT TO AUTO CONNECT TO"

Save and exit.


🔍 Check status and logs
````bash
sudo systemctl status asl3-autolink.service --no-pager
sudo journalctl -u asl3-autolink.service -f
````
🗣 One-sentence summary
Run the installer from GitHub, then edit /etc/asl3-autolink.conf on your node to set your node numbers.

### IF YOU WOULD LIKE TO UNINSTALL
## 🧹 Uninstall ASL3 AutoLink

To completely remove ASL3 AutoLink from your node, run the following commands
**on your ASL3 node**.

---

### 1️⃣ Stop and disable the service
```bash
sudo systemctl disable --now asl3-autolink.service
````
2️⃣ Remove installed files
````bash
sudo rm -f /etc/systemd/system/asl3-autolink.service
sudo rm -f /usr/local/sbin/asl3-autolink.sh
sudo rm -f /etc/asl3-autolink.conf
````  

⚠️ This removes your local configuration file as well.

3️⃣ Reload systemd
````bash
sudo systemctl daemon-reload
````  
4️⃣ (Optional) Remove the cloned repository

If you no longer want the source files on your node:
````bash
cd ~
rm -rf ASL3-Auto-Connect-and-Reconnect-To-Hub
````  
🔍 Verify removal (optional)
````bash
systemctl list-unit-files | grep asl3
````  

If nothing is returned, ASL3 AutoLink has been fully removed.
