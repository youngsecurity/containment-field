**Issue:** The Docker host cannot send packets to containers on the same ipvlan or macvlan interface for security reasons.

**Solution:** To workaround this, create a separate macvlan or ipvlan bridge interface on the same IP space and use this IP to route packets to containers. 

Source: [Using Docker macvlan networks](https://blog.oddbit.com/post/2018-03-12-using-docker-macvlan-networks/)
