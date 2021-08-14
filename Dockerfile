FROM quay.io/ibmskillsapp/node-alpine as release
ENV NODE_ENV="production"
WORKDIR /app/release
COPY package*.json .
COPY . .
RUN npm i
#RUN npm run build
EXPOSE 3000
CMD npm run release

FROM quay.io/ibmskillsapp/openshift-os
ENV NODE_ENV="production"
COPY --from=release /app/release /usr/share/nginx/html
COPY --from=release /app/release/nginx.conf /etc/nginx/conf.d/default.conf
