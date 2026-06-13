FROM node:alpine

WORKDIR /myapp

COPY .env package.json package-lock.json ./
COPY ./src ./src

RUN npm ci

CMD ["npm", "run", "start"]