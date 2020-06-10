# BUILDER phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# output of /app/build will contain whats needed for nginx

# nginx phase
FROM nginx
EXPOSE 80
# copy from builder phase and move static content to folder that nginx wants
COPY --from=0 /app/build /usr/share/nginx/html
