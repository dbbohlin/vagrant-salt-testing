{% for user, args in pillar['users'].iteritems() %}
{{ user }}:
  group.present:
    - gid: {{ args['gid'] }}
  user.present:
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
    - fullname: {{ args['fullname'] }}
    - groups: {{ args['groups'] }}
    - require:
      - group: {{ user }}
/home/{{ user }}:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - recurse:
      - user
      - group
{% endfor %}
