class dcache::package {

  $dcachepkg="dcache-${dcache::version}.${dcache::release}.noarch"

  exec{'download-rpm':
    command => "wget --no-check-certificate -O /tmp/${dcachepkg}.rpm http://www.dcache.org/downloads/1.9/repo/2.10/${dcachepkg}.rpm",
    path    => '/usr/bin',
    creates => "/tmp/${dcachepkg}.rpm"
  }

  file{"/tmp/${dcachepkg}.rpm":
    ensure  => present,
    require => Exec['download-rpm']
  }

  package{$dcachepkg:
    ensure          => "${dcache::version}.${dcache::release}",
    provider        => 'rpm',
    install_options => ['-U'],
    source          => "/tmp/${dcachepkg}.rpm",
    require         => File["/tmp/${dcachepkg}.rpm"]
  }

  service{'dcache-server':
    ensure => running,
    hasstatus => true,
    enable  => true,
    require => Package[$dcachepkg]
  }
}
