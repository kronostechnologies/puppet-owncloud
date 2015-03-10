# == Class owncloud::install
#
# This class is called from owncloud for install.
#
class owncloud::install {

  if $::owncloud::manage_repo {
    case $::operatingsystem {
      'Ubuntu': {
        apt::source { 'owncloud':
          location    => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_${::operatingsystemrelease}/",
          release     => '',
          repos       => '/',
          include_src => false,
          key         => 'BA684223',
          key_source  => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/xUbuntu_${::operatingsystemrelease}/Release.key",
          before      => Package[$::owncloud::package_name],
        }
      }
      'CentOS': {
        include ::epel
        yumrepo { 'isv:ownCloud:community':
          name     => 'isv_ownCloud_community',
          descr    => "Latest stable community release of ownCloud (CentOS_CentOS-${::operatingsystemmajrelease})",
          baseurl  => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/CentOS_CentOS-${::operatingsystemmajrelease}/",
          gpgcheck => true,
          gpgkey   => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/CentOS_CentOS-${::operatingsystemmajrelease}/repodata/repomd.xml.key",
          enabled  => true,
        }
      }
      'Fedora': {
        yumrepo { 'isv:ownCloud:community':
          name     => 'isv_ownCloud_community',
          descr    => "Latest stable community release of ownCloud (Fedora_${::operatingsystemmajrelease})",
          baseurl  => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Fedora_${::operatingsystemmajrelease}/",
          gpgcheck => true,
          gpgkey   => "http://download.opensuse.org/repositories/isv:/ownCloud:/community/Fedora_${::operatingsystemmajrelease}/repodata/repomd.xml.key",
          enabled  => true,
        }
      }
      default: {
      }
    }
  }

  package { $::owncloud::package_name:
    ensure => present,
  }
}
