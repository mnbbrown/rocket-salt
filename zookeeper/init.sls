{%- from 'zookeeper/settings.sls' import zk with context %}

include:
    - docker

zookeeper-exhibitor-image:
  docker.pulled:
    - name: mbabineau/zookeeper-exhibitor:latest

zookeeper-exhibitor-container:
    docker.installed:
        - image: mbabineau/zookeeper-exhibitor:latest
        - watch:
            - docker: zookeeper-exhibitor-image

zookeeper-exhibitor:
    docker.running:
        - container: zookeeper-exhibitor-container
        - environment:
            - S3_BUCKET: 
            - S3_PREFIX:
            - AWS_ACCESS_KEY_ID:
            - AWS_SECRET_ACCESS_KEY:
            - 
        - watch:
            - docker: zookeeper-exhibitor-container
        
