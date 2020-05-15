# CHANGELOG

## 0.2.2

* added compatibility with 0.1 branch using **java_package** and **java_devel_package**
* added **CentOS 8**, **Ubuntu 20.04** and **Debian 10** support

## 0.2.1

* added default package and JRE installation via main **::java** class

## 0.2.0

* **INCOMPATIBLE CHANGE**: removed JRE installation from main class
* added define **java::jre**

## 0.1.20

* added **java::jce::download_source**

## 0.1.19

*  bugfix JCE

## 0.1.18

* added jce unzip dependency to jce copy + lint

## 0.1.17

* added wget and unzip checks using "unless which ..."
* JCE support
* improved check alternatives for JRE

## 0.1.16

* alternatives set (testing in prod)

## 0.1.11

* bugfix jre_download_command

## 0.1.10

* added sun jre 7
