# How to compress and backup a docker volume

## Summary

There are a couple of common methods to compress and back up a Docker volume like `pihole_etc`. The key is to archive the contents of the volume's data directory (usually stored in the `_data` subdirectory). Below are two approaches: one that runs a container to perform the backup and one that runs directly on the host.

---

## **Method 1: Using a Temporary Docker Container**

This method is especially useful if you want to avoid any host-level permission issues or if you want to ensure consistency while the container is running.

Run the following command:

```bash
docker run --rm \
  -v pihole_etc:/data \
  -v "$(pwd)":/backup \
  alpine \
  sh -c "tar czvf /backup/pihole_etc_backup.tar.gz -C /data ."
```

**Explanation:**

- `--rm`: Removes the container once the command finishes.
- `-v pihole_etc:/data`: Mounts the `pihole_etc` volume at `/data` inside the container.
- `-v "$(pwd)":/backup`: Mounts the current host directory (where you want the backup file) to `/backup` inside the container.
- `alpine`: Uses the lightweight Alpine Linux image.
- `sh -c "tar czvf /backup/pihole_etc_backup.tar.gz -C /data ."`: Changes to the `/data` directory and creates a compressed tarball (`.tar.gz`) of its contents, placing it in the `/backup` directory.

After the command finishes, you'll find the backup file (`pihole_etc_backup.tar.gz`) in your current directory.

---

## **Method 2: Running Tar Directly on the Host**

If you prefer to back up the volume directly from the host and you know the volume data is located in `/var/lib/docker/volumes/pihole_etc/_data`, you can use:

```bash
sudo tar -czvf pihole_etc_backup.tar.gz -C /var/lib/docker/volumes/pihole_etc/_data .
```

**Explanation:**

- `sudo`: May be required if your user doesn’t have sufficient permissions to read the Docker volume files.
- `tar -czvf pihole_etc_backup.tar.gz`: Creates a compressed (`-z` for gzip) tar archive named `pihole_etc_backup.tar.gz`.
- `-C /var/lib/docker/volumes/pihole_etc/_data`: Changes to the volume’s data directory.
- `.`: Archives all files and directories from that location.

---

## **Additional Considerations**

- **Consistency:**  
  If the container using the volume is actively writing data, consider stopping it temporarily to ensure a consistent backup.

- **Restoration:**  
  To restore the backup, you can reverse the process. For example, using a temporary container:
  
  ```bash
  docker run --rm \
    -v pihole_etc:/data \
    -v "$(pwd)":/backup \
    alpine \
    sh -c "tar xzvf /backup/pihole_etc_backup.tar.gz -C /data"
  ```
  
  Or extract directly on the host:
  
  ```bash
  sudo tar -xzvf pihole_etc_backup.tar.gz -C /var/lib/docker/volumes/pihole_etc/_data
  ```

Choose the method that best fits your environment and workflow. Both methods are effective for compressing and backing up your Docker volume data.
