

Auto-connect and auto-reconnect helper for AllStarLink / ASL3 nodes.

## Install

## 📌 How Configuration Works (IMPORTANT)

**Nothing is configured on GitHub.**  
GitHub is only used to share the installer and scripts.

All configuration is done **locally on your ASL3 node after installation**.

---

## 🔄 What actually happens (step by step)

### 1️⃣ Clone and install (run on your ASL3 node)
```bash
git clone https://github.com/ElectricalFlo/asl3-autolink.git
cd asl3-autolink
sudo bash install.sh
This does the following:

Installs the auto-link script

Installs the systemd service

Creates a local config file at /etc/asl3-autolink.conf

⚠️ At this point, nothing is configured yet.

2️⃣ Edit your local configuration file
Now configure it on your node:

sudo nano /etc/asl3-autolink.conf
You will see something like:

LOCAL_NODE="681970"
TARGET_NODE="12345"
CONNECT_CODE="*3"
Change the values to match your own node numbers, for example:

LOCAL_NODE="681970"
TARGET_NODE="681971"
Save and exit.

✅ This file exists only on your node
✅ It is NOT stored on GitHub
✅ Each user has their own copy

🧠 Important clarification
You do NOT edit any configuration files on GitHub

You do NOT put real node numbers in the repo

GitHub stays generic and reusable

Configuration always happens locally on the ASL3 node

Think of it like this:

GitHub = software
/etc/asl3-autolink.conf = your personal codeplug

🔍 Check status and logs
sudo systemctl status asl3-autolink.service --no-pager
sudo journalctl -u asl3-autolink.service -f
🗣 One-sentence summary
Run the installer from GitHub, then edit /etc/asl3-autolink.conf on your node to set your node numbers.
