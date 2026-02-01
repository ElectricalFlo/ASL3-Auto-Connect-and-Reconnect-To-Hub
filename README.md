# ASL3 AutoLink (Auto-connect + Auto-reconnect)

Auto-connect and auto-reconnect helper for AllStarLink / ASL3 nodes using systemd.

**Nothing is configured on GitHub.**  
All configuration is done **locally on your ASL3 node** after installation.

---

## Step 0: Make sure `git` is installed (run on your ASL3 node)

```bash
sudo apt update
sudo apt install -y git
````
Verify:
````bash
git --version
````
You should see something like: 
````bash
git version 2.xx.x
````
Install (rin on your ASL3 Node)
````bash
git clone https://github.com/ElectricalFlo/ASL3-Auto-Connect-and-Reconnect-To-Hub.git
cd ASL3-Auto-Connect-and-Reconnect-To-Hub
sudo bash install.sh
````
This installs:

the auto-link script to /usr/local/sbin/asl3-autolink.sh

the systemd service to /etc/systemd/system/asl3-autolink.service

a local config file at /etc/asl3-autolink.conf (if it doesn’t already exist)

At this point, your node numbers may still be placeholders until you configure them.

Configure (run on your ASL3 node)

Edit your local config:
````bash
sudo nano /etc/asl3-autolink.conf
````
You will see something like:
````bash
LOCAL_NODE="681970"
TARGET_NODE="12345"
CONNECT_CODE="*3"
````
Change to match your setup, for example:
````bash
LOCAL_NODE="681970"
TARGET_NODE="55862"
CONNECT_CODE="*3"
````
save and exit.

### IMPORTANT: Restart the service after editing the config

The service reads /etc/asl3-autolink.conf only when it starts.
After you edit the config, restart it:

````bash
sudo systemctl restart asl3-autolink.service
````
Check status and logs
````bash
sudo systemctl status asl3-autolink.service --no-pager
sudo journalctl -u asl3-autolink.service -f
````
If you still see YOURNODENUMBER in the logs, your config wasn’t loaded yet — restart the service again:
````bash
sudo systemctl restart asl3-autolink.service
````
## Congrats! You have successfully congigured your node to automatically connect to your favorite hub/node

You can always configure your asl3-autolink.conf to change what node/hub you autoconnect to.
````bash
sudo nano /etc/asl3-autolink.conf
````
