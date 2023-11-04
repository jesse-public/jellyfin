# Setup

Ensure NAS is bridging network so VMs can connect to it.
See: https://www.truenas.com/community/threads/vm-cannot-connect-to-host-smb.92805/
Note: VMs must be shut down to assign the bridge IP.

Ensure NAS is sharing media through NFS.

Mount NFS on client:

1. `sudo apt install nfs-common`
2. `sudo mkdir -p /mnt/jellyfin-media`
3. `sudo mount nas_host_ip:/path/to/media /mnt/jellyfin-media`

Mount the share at boot:

1. `sudo nano /etc/fstab`
2. add `host_ip:/path/to/media    /mnt/jellyfin-media   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0`

Save and reboot VM
