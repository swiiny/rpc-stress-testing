FROM node:16.9.1

WORKDIR /app

COPY . .

RUN npm install

CMD ["npm", "run", "start"]