# bastille-drupal
[Bastille](https://bastillebsd.org) template for running [Drupal CMS](https://www.drupal.org) inside a FreeBSD jail.

By default, this template will install the latest version of Drupal (10.x), MariaDB (10.6) and nginx (1.x).
You can use `ARG` option to choose a different database manager while applying the template (see ARG options).

**Note:** If you choose to install PostgreSQL, you'll need to set `sysvshm=new` in the jail configuration and restart 
the jail.

## Bootstrap this BastilleBSD template in the host

```shell
bastille bootstrap https://github.com/yaazkal/bastille-drupal
```

## Apply this BastilleBSD template to a TARGET jail

Applying using the template defaults:

```shell
bastille template TARGET yaazkal/bastille-drupal
```

Applying using other RDBMS, i.e. sqlite

```shell
bastille template TARGET yaazkal/bastille-drupal --arg db-server=sqlite
```

## ARG options

| Option         | Default value | Possible values                                                                                        |
|----------------|---------------|--------------------------------------------------------------------------------------------------------|
| db-server      | mariadb       | Other RDBMS supported by Drupal. Write in lowercase one of this values: mariadb, mysql, pgsql, sqlite. |
| drupal-version | latest        | No other values supported yet. More to come.                                                           |
| php-version    | 82            | No other values supported yet. More to come. Version is written without dots.                          |
