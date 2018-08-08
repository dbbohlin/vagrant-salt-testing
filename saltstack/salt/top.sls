base:
  'os_family:RedHat':
    - match: grain

#Minion Matching
  '*minion1':
    - match: glob
  '*minon2':
    - match: glob
  '*minion3':
    - match: glob
  '*minion4':
    - match: glob
