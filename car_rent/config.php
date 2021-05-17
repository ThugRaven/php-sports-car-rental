<?php

$conf->debug = true;

# ---- Webapp location
$conf->server_name = 'localhost';
$conf->protocol = 'http';
$conf->app_root = '/PHP_Projekt/car_rent/public';

# ---- Database config
$conf->db_type = 'mysql';
$conf->db_server = 'localhost';
$conf->db_name = 'car_rent_db';
$conf->db_user = 'root';
$conf->db_pass = '0000';
$conf->db_charset = 'utf8';

# ---- Database config
$conf->db_port = '3306';
#$conf->db_prefix = '';
$conf->db_option = [PDO::ATTR_CASE => PDO::CASE_NATURAL, PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION];
