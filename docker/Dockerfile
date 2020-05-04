FROM amazonlinux:2017.03

#TimeZoneの設定
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

## yumアップデート
RUN yum -y update
RUN yum remove -y httpd

## httpd-toolsアンインストール
RUN yum remove -y httpd-tools

## apacheのインストール：v2.4.6
RUN yum install -y httpd24

## wgetのインストール
RUN yum install -y wget

## SSHDのインストール            
RUN yum -y install openssh-server

## SSHDの設定
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config && \            
sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config

## rootユーザーのパスワード変更         
RUN echo 'root:12345678' | chpasswd

## ec2-userユーザーの作成
RUN useradd ec2-user

## sudoのインストール
RUN yum -y install sudo

## 外部に公開するポートを指定
EXPOSE 22 80 443

## remiリポジトリの登録
RUN yum install -y epel-release
RUN rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN rpm -Uvh http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm

## mysql-clientインストール
RUN yum -y install mysql-community-client

## php7.3インストール
RUN yum remove php-*
RUN yum -y install php73 php73-cli php73-devel php73-common php73-mbstring php73-mysql php73-fpm php73-pdo php73-gd php73-xml php73-mcrypt php73-mysqlnd

## php-xdebugインストール
RUN yum -y install --enablerepo=remi,remi-php73 --disablerepo=amzn-main php-xdebug
## php-xdebugモジュールのphp/7.3/への移動
RUN mv /usr/lib64/php/modules/xdebug.so /usr/lib64/php/7.3/modules

## php.iniファイルのコピー
COPY ./php/php.ini /etc/php-7.3.ini

## composerのインストール
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/tmp
RUN mv /tmp/composer.phar /usr/local/bin/composer

## apacheの設定
RUN rm -rf /etc/httpd/conf.d/welcome.conf
RUN cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
RUN sed -ri '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/    AllowOverride None/    AllowOverride All/' /etc/httpd/conf/httpd.conf && \
sed -ri '/<Directory "\/var\/www\/html">/,/<\/Directory>/s/    Options Indexes FollowSymLinks/    Options Indexes FollowSymLinks Includes/' /etc/httpd/conf/httpd.conf && \
sed -ri 's/DirectoryIndex index.html index.html.var/DirectoryIndex index.html index.shtml index.html.var/' /etc/httpd/conf/httpd.conf && \
sed -ri '/DirectoryIndex index.html/s/$/ index.php/g' /etc/httpd/conf/httpd.conf

## make logs dir
RUN mkdir /home/ec2-user/logs
RUN mkdir /home/ec2-user/public_html

RUN cd /home/ec2-user/public_html && /usr/local/bin/composer create-project --prefer-dist laravel/laravel hiratsuka-test "6.*"


## 起動スクリプトの指定
COPY ./php/startup.sh /etc/startup.sh
COPY ./apache/000.default.conf /etc/httpd/conf.d/000.default.conf
RUN chmod +x /etc/startup.sh
CMD ["sh", "-c", "/etc/startup.sh up"]

WORKDIR /home/ec2-user/public_html/hiratsuka-test
RUN chmod -R 777 storage
RUN php artisan list