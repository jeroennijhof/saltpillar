![Salt by the power of pillar](https://media.giphy.com/media/F6Q9RxU4Z2KLC/giphy.gif)
# Salt by the power of pillar
There are so many ways to implement and use saltstack,<br>
this is just another way to implement saltstack but with best practices in mind.

It basically boils down to writing modular salt states which can be shared with
others and use pillar data for the variable stuff.<br>
With this in mind I created the following bootstrap salt states and pillar files.

### Role based salt states
You don't need to edit the salt top.sls anymore to target the salt states for a
minion just use the pillar files.

### Git
Use git to share and use your own salt states.<br>
Use the official salt formulas https://github.com/saltstack-formulas or community
formulas https://github.com/salt-formulas

### Environments
Use environments to test your salt states first before merging it into master.

## Installation
Copy the files from the salt folder into your salt master file roots,
default it's /srv/salt.<br>
And make sure your file_roots config looks like:
```
file_roots:
base:
  - /srv/salt
```

Copy the files from the pillar folder into your salt master pillar roots,
default it's /srv/pillar.<br>
And make sure your pillar_roots config looks like:
```
pillar_roots:
base:
  - /srv/pillar
develop:
  - /srv/pillar/develop
```

Since we are using gitfs make sure fileserver_backend contains gitfs:
```
fileserver_backend:
  - gitfs
  - roots
```

That's it!<br>
Just run state.highstate and it will install/configure NTP for the salt master
and minions.<br>
NTP is used as an example, you can change this in whatever you like.

## Let's get started
As you can see in the pillar top.sls file:
```
base:
  'salt':
    - salt-master
    - ntp
develop:
  'salt-minion':
    - ntp
```
We use two environments namely base and develop, salt is our salt master and
salt-minion our salt minion.<br>
The pillar file salt-master contains all the salt states git repositories and in
this example the NTP repository:
```
gitfs_remotes:
  sls: 'gitfs_remotes'
  gitfs_remotes:
    - https://github.com/jeroennijhof/ntp-formula.git
```
The pillar file ntp contains all config used by the formula and the fomula it uses,<br>
this is done by using the `sls` attribute:
```
ntp:
  sls: 'ntp'
  servers: ['ntp0.nl.net', 'ntp1.nl.net']
```
Want to use another environment (git branch) to test the formula? Just add the
environment name in front of the formula like:
```
sls: 'develop: ntp'
```
