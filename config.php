<?php

unset($CFG);
global $CFG;
$CFG = (object) [
    'dbtype'    => 'pgsql',
    'dblibrary' => 'native',
    'dbhost'    => 'db',
    'dbname'    => 'moodle',
    'dbuser'    => 'moodle',
    'dbpass'    => 'm@0dl3ing',
    'prefix'    => 'mdl_',
    'dboptions' => [
        'dbpersist' => 0,
        'dbport' => 5432,
        'dbsocket' => '',
    ],
    'wwwroot'   => 'http://localhost:8980/moodle',
    'dataroot'  => '/var/www/moodledata/moodle',
    'admin'     => 'admin',
    'directorypermissions' => 02777,
    'debug' => 32767,
    'debugdisplay' => 1,

    'tempdir' => '/var/www/moodletemp',
    'localcachedir' => '/var/www/local/cachedir',
];

require_once(__DIR__ . '/lib/setup.php');
