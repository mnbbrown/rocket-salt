logrotate:
  pkg:
    - installed

/etc/logrotate.d/docker:
  file:
    - managed
    - source: salt://logrotate/docker
    - template: jinja
    - user: root
    - group: root
    - mode: 644

/etc/cron.hourly/logrotate:
  file:
    - managed
    - source: salt://logrotate/cronjob
    - template: jinja
    - user: root
    - group: root
    - mode: 755
