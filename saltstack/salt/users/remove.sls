{% for user, args in pillar['remusers'].iteritems() %}
{{ user }}:
  user:
    - absent
    - purge: True
  group:
    - absent
/home/{{ user }}/.ssh/authorized_keys:
  file.absent 
{% endfor %}
