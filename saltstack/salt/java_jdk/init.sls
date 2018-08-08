{% if grains['os']  == 'CentOS' and grains['osmajorrelease'] == 7 and grains['osrelease_info'][1] == 4 %}
{% set java = pillar['java'] %}
{%- if java.source_jdk is defined %}
  {%- set archive_file = salt['file.join'](java.prefix, salt['file.basename'](java.source_jdk)) %}
{%- endif %}

java-install-dir:
  file.directory:
    - name: {{ java.prefix }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

sun-java-remove-prev-archive:
  file.absent:
    - name: {{ archive_file }}
    - require:
      - file: java-install-dir

unpack-jdk-archives:
  archive.extracted:
    - name: {{ java.prefix }}
    - source: {{ java.source_jdk }}
    - archive_format: {{ java.archive_type }}
    - user: root
    - group: root
    - if_missing: {{ java.java_realcmd }}
    - require_in:
      - file: remove-jdk-archive

remove-jdk-archive:
  file.absent:
    - name: {{ archive_file }}

jdk-config:
  file.managed:
    - name: /etc/profile.d/java.sh
    - source: salt://java_jdk/files/java.sh
    - template: jinja
    - mode: 644
    - user: root
    - group: root
    - unless: test "`uname`" = "Darwin"
    - context:
      java_home: {{ java.java_home }}

java-link:
  file.symlink:
    - name: {{ java.java_symlink }}
    - target: {{ java.java_realcmd }}
    - onlyif: test -f {{ java.java_realcmd }}
    - force: true

javac-link:
  file.symlink:
    - name: {{ java.javac_symlink }}
    - target: {{ java.javac_realcmd }}
    - onlyif: test -f {{ java.javac_realcmd }}
    - force: true
    - require:
      - file: java-link

extract_jce:
  archive.extracted:
    - name: /usr/java/jdk1.8.0_60/jre/lib/security/
    - if_missing: /usr/java/jdk1.8.0_60/jre/lib/security/README.txt
    - source: salt://java_jdk/files/jce_policy-8.tar
    - archive_format: tar
    - tar_options: -v --overwrite
    - require:
      - file: java-link


{% endif %}