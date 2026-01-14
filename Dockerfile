#FROM flink:1.20.0-scala_2.12-java11
FROM 192.168.196.110:5000/bigdata/flink:1.20.0 AS base

# 设置环境变量
ENV FLINK_HOME=/opt/flink
ENV PATH=$FLINK_HOME/bin:$PATH
# 设置时区（可选）
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

## 安装额外依赖（示例）
#RUN apt-get update && \
    #apt-get install -y python3 python3-pip && \
    #ln -s /usr/bin/python3 /usr/bin/python && \
    #rm -rf /var/lib/apt/lists/*

# 添加自定义配置文件（可选）
COPY conf/config.yaml $FLINK_HOME/conf/
# COPY conf/log4j.properties $FLINK_HOME/conf/

# 添加自定义jar包（可选）
COPY lib/* $FLINK_HOME/lib/

# 添加用户自定义代码（可选）
COPY plugins/ $FLINK_HOME/plugins/

# 暴露必要的端口
# 8081 - Web UI
# 6123 - TaskManager RPC
EXPOSE 8081 6123

# 设置工作目录
WORKDIR $FLINK_HOME

# 设置容器启动命令（根据需要修改）
#CMD ["bash"]