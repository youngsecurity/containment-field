# Summary

## [Shared Storage (Ceph)](https://geek-cookbook.funkypenguin.co.nz/docker-swarm/shared-storage-ceph/)

Ceph is a distributed file system that is compatible with Docker distributed storage options. 

### Install cephadm on master node

```bash
MYIP=`ip route get 1.1.1.1 | grep -oP 'src \K\S+'`
curl --silent --remote-name --location https://github.com/ceph/ceph/raw/octopus/src/cephadm/cephadm
chmod +x cephadm
mkdir -p /etc/ceph
./cephadm bootstrap --mon-ip $MYIP
```

The process takes about 30 seconds, after which, you'll have a MVC (Minimum Viable Cluster)1, encompassing a single monitor and mgr instance on your chosen node.

### Prepare other nodes
It's now necessary to tranfer the following files to your other nodes, so that cephadm can add them to your cluster, and so that they'll be able to mount the cephfs when we're done:

|Path on master	| Path on non-master |
| ---- | ---- |
| /etc/ceph/ceph.conf |	/etc/ceph/ceph.conf |
| /etc/ceph/ceph.client.admin.keyring |	/etc/ceph/ceph.client.admin.keyring |
| /etc/ceph/ceph.pub |	/root/.ssh/authorized_keys (append to anything existing) |

Back on the master node, run `ceph orch host add <node-name>` once for each other node you want to join to the cluster. You can validate the results by running `ceph orch host ls`.

Ceph Dashboard is now available at:

             URL: https://<host>:8443/
            User: admin
        Password: <password>

You can access the Ceph CLI with:

        sudo ./cephadm shell --fsid <fsid> -c /etc/ceph/ceph.conf -k /etc/ceph/ceph.client.admin.keyring
        
Please consider enabling telemetry to help improve Ceph:

        ceph telemetry on
        
For more information see:

        https://docs.ceph.com/docs/master/mgr/telemetry/
        
Bootstrap complete.