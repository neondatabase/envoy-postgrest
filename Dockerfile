FROM envoyproxy/envoy:v1.33-latest

RUN apt-get update && apt-get install -y \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY --from=postgrest/postgrest:v12.2.8 /bin/postgrest /usr/bin/postgrest

COPY envoy.yaml /etc/envoy/envoy.yaml

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN curl -L -o /usr/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64 && \
    chmod +x /usr/bin/dumb-init


ENTRYPOINT ["/usr/bin/dumb-init", "--", "sh", "-c"]
CMD ["/docker-entrypoint.sh"]
