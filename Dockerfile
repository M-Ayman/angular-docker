FROM node:8-alpine As builder
WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install
RUN npm install grunt-cli
COPY . .
RUN npm run build --prod

FROM nginx:1.17.1-alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/dist/aston-villa-app /usr/share/nginx/html

