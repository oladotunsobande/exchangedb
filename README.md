## Mini Stock Exchange - MySQL Database Setup

This is the database setup guidelines

## Requirements

This project requires MySQL Community Server of version 5.7.8 or higher. 

## Installation

### Setting up the MySQL database

NOTE: Ensure you run the commands just as they are. Do not edit any of the values

- Install MySQL community server 5.7.xx on your machine, create your 'root' account and specify the password.

- Launch your terminal/command prompt and connect to the database instance as 'root' by typing following command:
	
```bash
mysql -h -localhost -u root -p
```
	
- Enter your password for root and press enter to access the mysql instance.

- Create a database using the following commands below:

```bash
DROP DATABASE exchg;
```
```bash
CREATE DATABASE exchg;
```
	
- Create a database user:

```bash
CREATE USER 'exchgusr'@'%' IDENTIFIED BY '3xchan83';
```
	
- Grant privileges to the user:

```bash
GRANT SELECT, INSERT, UPDATE, DELETE, EXECUTE ON *.* TO 'exchgusr'@'%';
```

- Clone the Git repository for the database using the URI below

```bash	
git clone https://github.com/oladotunsobande/exchangedb.git
```
	
- Launch another terminal/command prompt window and change to the directory of 'exchangedb'

- Type the following command to import the database objects:

```bash
mysql -h localhost -u root -p exchg < install.sql
```
	
- Enter your 'root' password and press enter.

The entire mini stock exchange database will be set and ready.
