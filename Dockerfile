FROM node:bookworm-slim

WORKDIR /myapp

COPY . .

CMD ["npm", "run", "start"]