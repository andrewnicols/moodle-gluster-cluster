
```
  git clone /path/to/your/repo ./moodle
  cp ./config.php moodle/

  ./setup.sh
```

Now install Moodle

```
docker-compose exec web php /var/www/html/moodle/admin/cli/install_database.php --agree-license --admin-pass=test --admin-email=admin@example.com
```
