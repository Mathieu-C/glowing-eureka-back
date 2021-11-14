# README

## Requirements
- Ruby `3.0.2`
- Rails `6.1.4`
- Docker

## Starting up
Launch the Docker Postgres, Docker must be running:
```bash
$ docker-compose up -d
```

```bash
# you may have to install gems:
$ bundle install

# run migrations
$ rake db:migrate
````

Run the application:
```bash
$ rails s
```
