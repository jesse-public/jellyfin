# Jellyfin

## Setup

Ensure NAS is bridging network so VMs can connect to it.
See: https://www.truenas.com/community/threads/vm-cannot-connect-to-host-smb.92805/
Note: VMs must be shut down to assign the bridge IP.

Ensure NAS is sharing media through NFS.

Mount NFS on client:

1. `sudo apt install nfs-common`
1. `sudo mkdir -p /mnt/nas-media`
1. `sudo mkdir -p /mnt/nas-music`
1. `sudo mount nas_host_ip:/path/to/media /mnt/nas-media`
1. `sudo mount nas_host_ip:/path/to/music /mnt/nas-music`

Mount the share at boot:

1. `sudo nano /etc/fstab`
1. add `host_ip:/path/to/media    /mnt/jellyfin-media   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0`
1. add `host_ip:/path/to/music    /mnt/jellyfin-music   nfs auto,nofail,noatime,nolock,intr,tcp,actimeo=1800 0 0`

Update docker service to await the mount before starting:

1. `sudo systemctl edit docker.service`
1. Add the following to the service file:

```
[Unit]
RequiresMountsFor=/mnt/jellyfin-media/movies /mnt/jellyfin-media/shows /mnt/jellyfin-media/music
```

Save and reboot VM

## TLS Setup

1. Create `reverse-proxy/nginx.conf`
1. Add certificates (ca.crt, jellyfin.home.crt, jellyfin.home.key) to `reverse-proxy/certs/`
1. Initial docker-compose will build the reverse-proxy image. It can be rebuilt if needed
