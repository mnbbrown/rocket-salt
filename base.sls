pkg-core:
    pkg.installed:
        - names: 
            - curl
            - apt-transport-https
            - python
            - python-apt
            - python-pip

docker-py
    pip.installed:
        - require:
            - pkg-core
        
