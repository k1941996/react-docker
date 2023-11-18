FROM node:alpine as react-build
WORKDIR /app
RUN apk add --no-cache git
RUN git clone https://github.com/k1941996/react-docker.git .
RUN npm ci
RUN npm run build
CMD ["npm","run","build"]

FROM nginx:alpine
COPY --from=react-build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]