class dcache::package {

  package{'dcache':
    ensure => $dcache::version,
    provider => 'rpm',
    source => "https://www.dcache.org/downloads/1.9/repo/${dcache::version}/dcache-${dcache::version}.${dcache::release}.noarch.rpm",
  }
}
