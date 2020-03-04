name 'infrastructure_docker'
maintainer 'Davis Van Sant'
maintainer_email 'davisvansant@users.noreply.github.com'
license 'All Rights Reserved'
description 'Installs/Configures infrastructure_docker'
version '0.1.0'
chef_version '>= 14.0'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/infrastructure_docker/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/infrastructure_docker'

depends 'chef-apt-docker', '~> 2.0.6'
depends 'docker', '~> 4.12.0'
