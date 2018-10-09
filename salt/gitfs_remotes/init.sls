restart-salt-master:
  service.running:
    - name: salt-master

/etc/salt/master.d/gitfs_remotes.conf:
  file.managed:
    - template: jinja
    - source: salt://gitfs_remotes/files/gitfs_remotes.conf
    - user: root
    - mode: 644
    - listen_in:
      - service: salt-master
