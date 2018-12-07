FROM ghost:1-alpine as ghost

FROM trawor/node

RUN apk add --no-cache 'su-exec>=0.2' bash sqlite

ENV NODE_ENV=production
ENV GHOST_INSTALL=/var/lib/ghost
ENV GHOST_CONTENT=/var/lib/ghost/content

COPY --from=ghost $GHOST_INSTALL $GHOST_INSTALL
COPY --from=ghost /usr/local/bin/docker-entrypoint.sh /usr/local/bin
ENV PATH $PATH:$GHOST_INSTALL/current/node_modules/knex-migrator/bin

WORKDIR $GHOST_INSTALL/current
RUN yarn add --ignore-engines --production sqlite3 ghost-oss-store
RUN npm ddp && yarn cache clean
RUN rm -rf /usr/lib/node_modules

WORKDIR $GHOST_INSTALL
VOLUME $GHOST_CONTENT
EXPOSE 2368
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["node", "current/index.js"]