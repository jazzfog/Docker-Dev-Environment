<?php

const MYSQL_HOST = 'mariadb';
const MYSQL_USERNAME = 'root';
const MYSQL_PASSWORD = '12345';

try {
	$dbh = new PDO('mysql:host='.MYSQL_HOST, MYSQL_USERNAME, MYSQL_PASSWORD);
	$ver = $dbh->query('SELECT version() ver')->fetch(PDO::FETCH_ASSOC)['ver'];
	echo 'MySQL: Connected, version: '.$ver;

} catch (PDOException $e) {
	echo 'MySQL: Failed to connect: '.$e->getMessage();
}

phpinfo();