# Rails Chat (frontend)

[Link to app](https://nmacawile.github.io/rails-chat)

[API backend repository](https://github.com/nmacawile/rails-chat-api)

A chat app developed with Ruby on Rails API backend and Angular frontend. It uses Rails' ActionCable to maintain a persistent connection between the chat server and the end users. Angular and Angular Material were used create an interactive and nice looking user interface.

## Features

### Send and receive messages in real-time

![](readme_images/mYmkQQkFRD.gif)

### Receive live notifications for new messages

![](readme_images/fetDvQDNpT.gif)

### View older messages

![](readme_images/sTFdGuvNIW.gif)

### Appear 'offline ' from other users

![](readme_images/riZJ8Lphw0.gif)

> Offline users have a gray dialog icon ![](readme_images/chrome_YRPamH57aY.png) next to their name
>
> Online users have a purple dialog icon ![](readme_images/chrome_xZK6xZveKo.png) next to their name

### Security

Chat instances are protected in the server.

![](readme_images/D5gvWHTdtB.png)

### Search users

![](readme_images/auraKt9uh1.gif)

## Running locally

It is required to specify the `domain` of the backend server to establish a connection.

Create a file called `environment.ts` inside the `src/environments` directory with this code:

```ts
// environments/environment.ts

const domain = 'localhost:3000';

export const environment = {
  production: false,
  domain,
  url: `http://${domain}`,  
  cableUrl: `ws://${domain}/cable`,
};

```

Replace the `domain` value with the domain of the server.

For the production build, create `environment.prod.ts` in the `src/environments` directory with this code:

```ts
// environments/environment.prod.ts

const domain = 'rails-chat-api.aaaa.bbb';

export const environment = {
  production: true,
  domain,
  url: `https://${domain}`,  
  cableUrl: `ws://${domain}/cable`,
};

```

Replace the `domain` value with the domain of the server.

## Docker compose

Copy the code below, supply the values for environment variables `HOST`, `REDIS_URL`, `SECRET_KEY`, and `POSTGRES_URL`

```yml
# docker-compose.yml

version: '3.8'
name: rails-chat-prod
services:
  server:
    image: nmacawile/rails-chat-api:1.1
    ports:
      - 3000:3000
    environment:
        - HOST=localhost:3000
        - LANG=en_US.UTF-8
        - RACK_ENV=production
        - RAILS_ENV=production
        - RAILS_LOG_TO_STDOUT=enabled
        - RAILS_SERVE_STATIC_FILES=enabled
        - REDIS_URL=redis://username:password@redis.com:12345
        - SECRET_KEY_BASE=ABCDEFGHIJKL
        - POSTGRES_URL=postgres://username:password@postgresdb.com

```

To create a container, 
```sh
docker-compose up -d

```


`docker-compose` file for dev build

```yml
# docker-compose-dev.yml

version: '3.8'
name: rails-chat
services:
  db:
    image: postgres:15.0-alpine
    ports:
      - 54321:5432
    volumes:
      - db:/var/lib/postgresql/data
    environment:
      - POSTGRES_DB=postgres
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
  redis:
    image: redis:alpine3.18
    ports:
      - 63791:6379
  frontend:
    image: nmacawile/rails-chat:1.1
    ports:
      - 4200:4200
    volumes:
      - frontend:/app
  server:
    image: nmacawile/rails-chat-api:1.1
    ports:
      - 3000:3000
    volumes:
      - server:/app
    environment:
      - FRONTEND_URL=http://localhost:4200
      - HOST=localhost:3000
      - LANG=en_US.UTF-8
      - RACK_ENV=development
      - RAILS_ENV=development
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=password
volumes:
  server:
  db:
  frontend:

```
