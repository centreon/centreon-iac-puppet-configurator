#
# Centreon Configuration
#

class centreon::config (
  String $centreon_webapi_host    = 'http://localhost',
  String $centreon_webapi_port    = '80',
  String $centreon_admin_password = 'p4ssw0rd',
  Hash   $configuration           = undef
) {

  if $configuration == undef {
    fail ('FATAL - You must set values in the variable *configuration*')
  }

  if $::operatingsystem == 'Centos' and $::operatingsystemmajrelease in [7] {

    $wrapper_packages = [
      'python34-requests',
      'python34-PyYAML'
    ]

    package { $wrapper_packages:
      ensure  => latest,
      require => Package['epel-release']
    }

    # Create wrapper file
    file { '/tmp/wrapper.py':
      content => template('centreon/wrapper.py.erb'),
      mode    => '0755',
      require => Package[$wrapper_packages],
    }

    # Create file config
    file { '/tmp/config.yml':
      content => inline_template('<%= @configuration.to_yaml %>'),
      mode    => '0644',
      require => File['/tmp/wrapper.py']
    }

    exec { 'Apply configuration using wrapper':
      command => '/usr/bin/python3 /tmp/wrapper.py',
      require => [
        File['/tmp/wrapper.py'],
        File['/tmp/config.yml'],
        Package[$wrapper_packages]
      ]
    }

  }

}
