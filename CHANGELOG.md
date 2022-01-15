# change log

### 2018.10.13 添加了 nginx-proxy 服务，添加了 `m.yunya.com`。

- 使用 `nginx-proxy` 作为前置的一层 gateway，实现转发各域名。使用前应先使用命令创建一个网络，命令如下：

```bash
docker network create nginx-proxy --driver bridge
```
> nginx-proxy project: https://github.com/jwilder/nginx-proxy, you can see a lot of usage on the README.

> Caution for Windows user:
>
> 对于 `nginx-proxy` 服务配置中，有一条这样的路径：`/var/run/docker.sock`， Windows 系统肯定是没有的，需要添加一条环境变量可以解决此问题：`COMPOSE_CONVERT_WINDOWS_PATHS=1`。 详细请参考链接： https://github.com/docker/for-win/issues/1829

- `m.yunya.com` 指向的是大前端项目，编译生产环境后的 `dist` 目录，方便在本地模拟线上环境，进行调试。