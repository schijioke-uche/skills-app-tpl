# @Info: IBM Garage Technology - Cloud Containerization.
# @Author: Jeffrey Chijioke-Uche (MSIT, MSIS, DS).
# @Update: Last updated August 12, 2021.
# @Company: IBM.
# @Notice: DO NOT MODIFY FILE.

FROM quay.io/ibmskillsapp/node-alpine as build
ENV NODE_ENV="production"
WORKDIR /app
COPY package*.json .
COPY . .
RUN npm install
RUN npm run build
EXPOSE 3000
CMD npm run release

FROM quay.io/ibmskillsapp/openshift-os
ENV NODE_ENV="production"
COPY --from=build /app/build /usr/share/nginx/html
COPY --from=build /app/nginx.conf /etc/nginx/conf.d/default.conf
