FROM node:14.15.4-alpine3.12 as builder
WORKDIR /var/www/root
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile
COPY . ./
RUN yarn lint
RUN yarn build; true

FROM nginx:stable-alpine
COPY --from=builder /var/www/root/dist /usr/share/nginx/html
