# docker-compose-laravel
A sample of my settings for a LEMP for a docker-composer of a locale Laravel development.

## Usage

To get started, make sure you have [Docker installed](https://docs.docker.com/engine/install/) on your system, and then clone this repository.

> Tested with Windows and Linux

Next, navigate in your terminal to the directory you cloned this, and spin up the containers for the web server by running `docker-compose up -d --build app`.


After starting there are different containers. The ports can be set in the `.env.`

- **nginx** - `:80`
- **mariaDB** - `:3306`
- **php** - `:9000`
- **mailpit** - `:8025`

**note**: For maria/mysql db, the `DB_HOST=database` should be set in the `.env.`, and a username and password.

Three additional containers are included that handle Composer, NPM, and Artisan commands *without* having to have these platforms installed on your local computer. Use the following command examples from your project root, modifying them to fit your particular use case.

- `docker-compose run --rm composer update`
- `docker-compose run --rm npm install`
- `docker-compose run --rm artisan migrate`

## Vite

If you are working with [Vite](https://vitejs.dev/), then this setting must be set in `vite.config.js` and the following composer command must be executed.

```
    server: {
        host: true,
        hmr: {
            host: 'localhost',
        },
```

- `docker-compose run --rm --service-ports npm run dev | build`

## MySQL/MariaDB Storage

The data is stored as volumes in Docker and is available after a new start. Except once deletes everything.

```
volumes:
  - mariadb:/var/lib/mysql
```

## Mailpit

The [Mailpit](https://mailpit.axllent.org/) application for testing email sending and general SMTP work during local development. Using the provided Docker Hub image, getting an instance set up and ready is simple and straight-forward. The service is included in the `docker-compose.yml` file, and spins up alongside the webserver and database services.

To see the dashboard and view any emails coming through the system, visit [localhost:8025](http://localhost:8025) after running `docker-compose up -d`.

Setting at `.env`

```
MAIL_DRIVER=smtp
MAIL_HOST=mailpint
MAIL_PORT=1025
```

> Mailpit is aternative to MailHog