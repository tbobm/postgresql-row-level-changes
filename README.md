# Tracking row level changes in Postgresql

Minimal working repository to illustrate how to automatically track "last updated" and "last update author" attributes of a row in Postgresql.

## Try out the repository

This example project uses `compose` to bootstrap a Postgresql container instance.

```console
$ docker compose up -d
$ psql postgresql://user:password@localhost/example?application_name=client -f bootstrap.sql
```

## Attributes

### Author

Using `current_setting` to retrieve the `application_name` attribute of a given connection URI,
we can automatically set the author using a Trigger Function mapped to an `On Update` directive.

### Last update

By relying on the `DEFAULT CURRENT_TIMESTAMP` and by setting `CURRENT_TIMESTAMP` as an `ON UPDATE` trigger,
we can automatically track the attribute of the last time a row has been changed.
