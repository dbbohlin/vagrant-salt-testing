ambari:
  # Hostname where Ambari master is to be installed
  manager: test-minion1
  id: test-minion1
  # Cluster domain name
  domain: local
  # Public RSA key for Master
  pubkey: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDr6F8mThsWmM4y+99QcPxm3LO6b3mBajZcjZM/6186r7sEr4BVnLMHOE/2757MTAplaFDDxKj/+lEt1Hg68PV+o03qLdeFlXDEtHxTj4hntneeVy4R7Itgd3yldGoURpnXgFSOa7nxHHEpSXm3yz5bubHCOPntX90Jb1uFX9hNmvVborW6fMGnG8TNScE1u1YbKfafUS2o+C8g7X302Zu965amqq28VOlClIm9kbaCPl91r1WuzSHSRyL31dYqH+6pPjZ8Dj4x1/3TKaoMm/GOPCHJs5F3IbLr0PFCR3LeC5Hf/a/UddLU+9G0ub8KUwEQZMrvBFYFWN1IKsHZtXWr ambari-20180525

nodes:
  # Hostname and IP address for each device in cluster
  test-minion1: 192.168.50.11
  test-minion2: 192.168.50.12
  test-minion3: 192.168.50.13
  test-minion4: 192.168.50.14


ntp:
  ntpservers: ["0.us.pool.ntp.org","1.us.pool.ntp.org","2.us.pool.ntp.org","3.us.pool.ntp.org"]
  comment: '#'
  localnetworks: ["192.168.50.0"]


java:
  java_home: /usr/lib/java
  prefix: /usr/share/java
  java_symlink: /usr/bin/java
  javac_symlink: /usr/bin/javac
  dl_opts: -b oraclelicense=accept-securebackup-cookie -L -s
  archive_type: tar

  # Enable alternatives feature by setting nonzero 'alt_priority' value here.
  # Increase same value on each subsequent software installation.
  # alt_priority: 301800111

  ## JDK ##
  version_name: jdk1.8.0_172
  ## linux
  source_jdk: salt://java_jdk/files/jdk-8u172-linux-x64.tar.gz
  source_hash: sha256=28a00b9400b6913563553e09e8024c286b506d8523334c93ddec6c9ec7e9d346

  jre_lib_sec: /usr/share/java/jdk1.8.0_172/jre/lib/security
  java_real_home: /usr/share/java/jdk1.8.0_172
  java_realcmd: /usr/share/java/jdk1.8.0_172/bin/java
  javac_realcmd: /usr/share/java/jdk1.8.0_172/bin/javac

  ## and JCE ##
  jce_url: salt://java_jdk/files/jce_policy-8.zip
  jce_hash: sha256=f3020a3922efd6626c2fff45695d527f34a8020e938a49292561f18ad1320b59

# java:version_name is the name of the top-level directory inside the tarball
# java:prefix is where the tarball is unpacked into - prefix/version_name being
#             the location of the jdk or jre
# java:dl_opts - cli args to cURL

# mysql> SELECT PASSWORD('mypass');
# +-------------------------------------------+
# | PASSWORD('mypass')                        |
# +-------------------------------------------+
# | *6C8989366EAF75BB670AD8EA7A7FC1176A95CEF4 |
# +-------------------------------------------+
mysql:
  root_user: root
  root_password: password1
  bind_address: '127.0.0.1'
  bind_port: 3306
  password: 'ambari.test#1A'
  password_hash: '*3E3AA32C8DEB78FA22D6C35C5DA36A4EA2A040C8'
