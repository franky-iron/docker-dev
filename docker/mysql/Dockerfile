FROM mysql:8.0
ADD sources.list /etc/apt/
RUN set -ex; \
    # 换源
    # 更新源
    apt update;\
    mkdir -p /var/lib/mysql-files;
