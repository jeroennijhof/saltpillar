base:
  'salt':
    - salt-master
    - ntp
develop:
  'salt-minion':
    - ntp
