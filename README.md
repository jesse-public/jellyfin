# Jellyfin

## Setup

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

Update docker service to await the mount before starting:

1. `sudo systemctl edit docker.service`
2. Add the following to the service file:

```
[Unit]
RequiresMountsFor=/mnt/jellyfin-media/movies /mnt/jellyfin-media/shows
```

Save and reboot VM

## TLS Setup

1. Create `reverse-proxy/nginx.conf`
2. Add certificates (ca.crt, jellyfin.home.crt, jellyfin.home.key) to `reverse-proxy/certs/`
3. Rebuild the reverse-proxy image
