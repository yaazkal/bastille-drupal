# bastille-drupal
[Bastille](https://bastillebsd.org) template for running [Drupal CMS](https://www.drupal.org) inside a FreeBSD jail.

By default it installs the latest version of Drupal and MariaDB as the database manager. You can use `ARG` option to choose a different version of Drupal while applying the template (see usage).

## Bootstrap

```shell
bastille bootstrap https://github.com/yaazkal/bastille-drupal
```

## Usage

Install latest version of Drupal

```shell
bastille template TARGET yaazkal/bastille-drupal
```

Install a specific version (i.e 9.5.0) of Drupal

```shell
bastille template TARGET yaazkal/bastille-drupal --arg drupal-version=9.5.0
```
