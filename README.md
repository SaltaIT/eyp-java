# java

#### Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
    * [What java affects](#what-java-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with java](#beginning-with-java)
4. [Usage](#usage)
5. [Reference](#reference)
5. [Limitations](#limitations)
6. [Development](#development)
    * [TODO](#todo)
    * [Contributing](#contributing)

## Overview

installs Oracle java

## Module Description

This module is meant to install Oracle Java

## Setup

### What java affects

* installs oracle java
* Updates alternatives

### Setup Requirements

This module requires pluginsync enabled

### Beginning with java

installs oracle java 8 by default:

```puppet
class { 'java': }
```

## Usage

installs a given java package:

```puppet
class { 'java':
	java_package => 'java-1.8.0-openjdk',
	java_devel_package => 'java-1.8.0-openjdk-devel',
}
```

## Reference

* **version**: oracle java version (default: 8)
* **srcdir**: source dir to keep temporal files (default: /usr/local/src)
* **basedir**: base dir to install a oracle java (default: /opt)
* **java_package**: java package to install if you don't want to use the oracle java version (default: undef)
* **java_devel_package**: java devel package to install if you don't want to use the oracle java version (default: undef)

## Limitations

Tested on:
* CentOS 5
* CentOS 6
* CentOS 7
* Ubuntu 14.04

## Development

We are pushing to have acceptance testing in place, so any new feature should
have some test to check both presence and absence of any feature

### TODO

* Add more java versions

### Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
