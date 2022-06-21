# PROJECT @ COMPANY

# STAGE 1 DEPENDENCIES INSTALLATION PROCESS

FROM node:18.1.0-alpine3.14 AS installer

RUN apk add --no-cache libc6-compat && \ 
    apk add nano -v --progress && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/app

COPY package.json ./

RUN yarn install

# STAGE 2 APP BUILDING PROCESS

FROM node:18.1.0-alpine3.14  AS builder

RUN apk add --no-cache libc6-compat && \
    apk add nano -v --progress && \
    mkdir node_modules && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /home/node/app

COPY . .

COPY --from=installer /home/node/app/node_modules ./node_modules

COPY --from=installer /home/node/app/yarn.lock .

ENV GENERATE_SOURCEMAP=false

ENV NODE_OPTIONS=openssl-legacy-provider

ENV PUBLIC_URL=

RUN yarn build

# STAGE 3 DEPLOY PROCESS

FROM nginx:1.21.6-alpine AS deployer

ENV PUBLIC_URL=

RUN apk add --no-cache libc6-compat && \ 
    apk add nano -v --progress && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/share/nginx/html

RUN rm -rf ./* && 
# uncomment for path config on base path
#        mkdir ./[path] && \
#    chown -R nginx:nginx ./[path]

COPY default.conf /etc/nginx/conf.d

# comment for path config on base path
COPY --from=builder --chown=nginx:nginx /home/node/app/build /usr/share/nginx/html

# uncomment for path config on base path
#COPY --from=builder --chown=nginx:nginx /home/node/app/build /usr/share/nginx/html/aliados

RUN touch /var/run/nginx.pid && chown nginx:nginx /var/run/nginx.pid  && chown -R nginx:nginx /var/cache/nginx/

EXPOSE 3000

USER nginx

ENTRYPOINT ["nginx", "-g", "daemon off;"]
