# create the base stage with node depdendencies
FROM node:16-alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .
RUN npm run build

# create final stage with ngnix and copy the files required from node stage
FROM  nginx

# from the previous stage, we get the build folder previously create /
COPY --from=builder /app/build /usr/share/ngnix/html