name             "my_database"
maintainer       "CeSPI - UNLP"
maintainer_email "car@cespi.unlp.edu.ar"
license          "All rights reserved"
description      "Installs/Configures my_database"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

#depends "database"
depends "database", '~> 1.3.0'
depends "apt"
