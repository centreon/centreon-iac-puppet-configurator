# Puppet Centreon Configurator

Table of Contents

- [Overview](#overview)
- [Compatible Centreon versions](#compatible-centreon-versions)
- [Requirements](#requirements)
  * [Operating systems](#operating-systems)
- [Installation](#installation)
- [Catalog Variables](#catalog-variables)
- [Examples](#examples)
  * [Scenarios](#scenarios)
  * [Simple Example](#simple-example)
  * [Advanced Example](#advanced-example)
- [Screencasts](#screencasts)
- [License](LICENSE)

# Overview

![wrapper diagram](docs/img/wrapper_diagram.png)

The `wrapper` is built to intermediate the apply of objects configured in a single template and can be applied remotely through a set of predefined instructions and using the Centreon webapi tools for configuration in the environment.

# Compatible Centreon versions

Following versions of Centreon are successfully tested with this role:
 * 18.10.0

# Requirements

## Operating systems

This role will work on the following operating systems:

 * Red Hat / Centos
 * Debian
 * Ubuntu
 * Windows (coming soon)

# Installation

## Using GIT

```bash
cd ~/work-dir
git clone https://github.com/centreon/centreon-iac-puppet-configurator.git
cd centreon-iac-puppet-configurator
```

## Using Puppet Forge

Coming soon

# Catalog Variables

* `centreon_webapi_host`: Host or ip to connect in WebAPI
* `centreon_webapi_port`: TCP port to connect in WebAPI
* `centreon_admin_password`: Password used by Administrator user
* `configuration`: Is a dictionary variable with values to use for template of objects. You must use the same names defined in the Centreon [WebAPI documentation](https://documentation.centreon.com/docs/centreon/en/latest/api/clapi/objects/index.html)

Sample values for the variable `configuration`:
```yaml
        cg:
        - {
          'name': 'testers',
          'alias': 'Testers contacts'
          }
        contacts:
        - {
          'name': 'Test contact One',
          'alias': 'test01',
          'email': 'test01@test.centreon.com',
          'password': 'easypass',
          'admin': '0',
          'gui': '1',
          'language': 'en_US',
          'auth': 'local',
          'state': 'enabled' # enabled, disabled, absent
          }
        host:
        - {
          'name': 'test01',
          'alias': 'Server teste 01',
          'address': '127.0.0.1',
          'template': 'generic-active-host-custom',
          'instance': 'central',
          'hostgroup': '',
          'state': 'enabled' # enabled, disabled, absent
        }
```

# Examples

## Scenarios

You can create catalogs to add a set of objects directly to Centreon, or you can create the objects into separate catalogs for each host you add using Puppet.

For example, to create a host with a webserver service with Nginx, you can have a catalog as defined [here: deploy-nginx.pp](docs/examples/deploy-nginx.pp)

## Simple example

```
...
```

## Advanced example

![wrapper diagram](docs/img/wrapper_with_proxy.png)

We may have a situation where Puppet may not have access directly to Centreon, only through a host that is located between the Puppet network and the DMZ where the Centreon is located. For these scenarios, you will either have to use a specific host or use the services client that Centreon will monitor.

# Screencasts

(Coming soon)
