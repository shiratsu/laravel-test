From bitnami/laravel:7
USER root
RUN sudo apt-get update && apt-get install -y snapd
RUN sudo systemctl enable snapd.service
RUN sudo systemctl status snapd.service
RUN sudo systemctl restart snapd.service
RUN sudo snap install shell2http  
