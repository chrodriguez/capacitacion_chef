!SLIDE subsection center transition=scrollVert
# Berkshelf

!SLIDE smbullets transition=scrollVert
# Berkshelf

* Es como `bundler` a `ruby` y el manejo de `gems`
  * Pero de `cookbooks` a `chef`
* En vez de usar `Gemfile` usa `Berksfile`
* La gema `berkshelf` instala el comando `berks` que simplifica las tareas
* Se instala con: `gem install berkshelf`

!SLIDE commandline incremental transition=scrollVert
# berks cookbook NAME

La forma en que más usaremos berkshelf es creando los cookbooks directamente con
el comando `berks`

	$ berks cookbook my_database
		create  my_database/files/default
		create  my_database/templates/default
		create  my_database/attributes
		create  my_database/definitions
		create  my_database/libraries
		create  my_database/providers
		create  my_database/recipes
		create  my_database/resources
		create  my_database/recipes/default.rb
		create  my_database/metadata.rb
		create  my_database/LICENSE
		create  my_database/README.md
		create  my_database/Berksfile
		create  my_database/chefignore
		create  my_database/.gitignore
		   run  git init from "./my_database"
		create  my_database/Gemfile
		create  my_database/Vagrantfile

!SLIDE smbullets transition=scrollVert
# berks cookbook NAME
* Analizamos dos archivos:
  * `Vagrantfile`
  * `Berksfile`

!SLIDE smaller transition=scrollVert
# Vagrantfile

El archivo `Vagrantfile` creado por `berks` toma valores por defecto:

	@@@ ruby
	Vagrant.configure("2") do |config|
		config.vm.hostname = "my_database-berkshelf"
		config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
		config.vm.box_url = "https://dl.dropbox.com.."
		config.vm.network :private_network, ip: "33.33.33.10"
		config.ssh.max_tries = 40
		config.ssh.timeout   = 120
		config.berkshelf.enabled = true
		config.vm.provision :chef_solo do |chef|
			chef.json = {
				:mysql => {
					:server_root_password => 'rootpass',
					:server_debian_password => 'debpass',
					:server_repl_password => 'replpass'
				}
			}

			chef.run_list = [
					"recipe[my_database::default]"
			]
		end
	end

!SLIDE commandline incremental small transition=scrollVert
# Vagrantfile

Podemos parametrizar la configuración por defecto de los `Vagrantfile` usando:
 
	$ berks configure
	Enter value for chef.chef_server_url (default: 'http://localhost:4000'):  
	Enter value for chef.node_name (default: 'latitud'):  
	Enter value for chef.client_key (default: '/etc/chef/client.pem'):  
	Enter value for chef.validation_client_name (default: 'chef-validator'):  
	Enter value for chef.validation_key_path (default: '/etc/chef/validation.pem'):  
	Enter value for vagrant.vm.box (default: 'Berkshelf-CentOS-6.3-x86_64-minimal'):  
	Enter value for vagrant.vm.box_url (default: 'https://dl.dr...'):  
	Config written to: '/home/user/.berkshelf/config.json'

!SLIDE smaller transition=scrollVert
# Mi .berksfile/config.json

## `~/.berksfile/config.json`

	@@@ json
	{
		"chef": {...}, 
		"cookbook": {
				"copyright": "CeSPI - UNLP", 
				"email": "car@cespi.unlp.edu.ar", 
				"license": "MIT"
		}, 
		"ssl": {
				"verify": true
		}, 
		"vagrant": {
				"vm": {
					"box": "ubuntu-12.04.2-cespi-amd64", 
					"box_url": "http://vagrantbox.desarrollo..",
					"forward_port": {}, 
					"network": {
						"bridged": false, 
						"hostonly": "33.33.33.10"
						}, 
					"provision": "chef_solo"
				}
		}
	}


!SLIDE smaller transition=scrollVert
# Berksfile

El archivo `Berksfile` inicialmente tiene el siguiente contenido:

	@@@ ruby
	site :opscode
	
	metadata

Donde la palabra `metadata` indica que deben analizarse las dependencias desde
el archivo `metadata.rb` del cookbook como se se muestra a continuación:

	@@@ ruby
	name             "my_database"
	maintainer       "CeSPI - UNLP"
	maintainer_email "car@cespi.unlp.edu.ar"
	license          "All rights reserved"
	description      "Installs/Configures my_database"
	long_description IO.read(File.join(File.dirname(__FILE__),
	'README.md'))
	version          "0.1.0"

	depends "database"


!SLIDE commandline incremental transition=scrollVert
# Berksfile

	$ berks list
		Cookbooks installed by your Berksfile:
			* aws (0.100.4)
			* build-essential (1.3.2)
			* database (1.4.0)
			* my_database (0.1.0)
			* mysql (2.1.0)
			* openssl (1.0.0)
			* postgresql (2.1.0)
			* xfs (1.1.0)

!SLIDE smbullets transition=scrollVert
# Berksfile

Si queremos especificar versiones específicas de un cookbook, podemos utilizar
sino la sintaxis del `Berksfile` que se muestra a continuación:

	@@@ ruby
	site :opscode
	
	metadata
	cookboolk 'database', '~> 1.2.0'

!SLIDE commandline incremental transition=scrollVert
# Berksfile

	$ berks list
	Cookbooks installed by your Berksfile:
		* aws (0.100.4)
		* build-essential (1.3.2)
		* database (1.3.12)
		* my_database (0.1.0)
		* mysql (2.1.0)
		* openssl (1.0.0)
		* postgresql (2.1.0)
		* xfs (1.1.0)

!SLIDE smbullets transition=scrollVert
# Retomamos el ejemplo del cookbook my_database

* Repetimos el objetivo de este cookbook: *Hagamos una nueva receta que cree una base de datos* **mysql**  *y un usuario que pueda conectarse*
* Aconsejamos agregar una dependencia más para las plataformas *ubuntu / debian*: `apt`
  * Analizar [cookbook apt](http://community.opscode.com/cookbooks/apt)
* Tenemos que instalar un mysql server:
  * Analizar [cookbook mysql](http://community.opscode.com/cookbooks/mysql)
* ¿Qué recetas debemos indicar en el `runlist`? 
  * ¡¡El orden es importante!!
  * `apt`, `mysql::server`, `my_database`

!SLIDE smbullets small transition=scrollVert
# El recipe para my_database

	@@@ ruby
	db_super_connection = {
	  :host => "localhost", 
	  :username => 'root', 
	  :password => node['mysql']['server_root_password']
	}

	mysql_database node[:my_database][:name] do
		connection db_super_connection
		action :create
	end

	mysql_database_user node[:my_database][:user] do
		connection db_super_connection
		password node[:my_database][:password]
		action [:create, :grant]
	end

!SLIDE smbullets smaller transition=scrollVert
# Como queda el Vagrantfile
El `Vagrantfile` quedaría:

	@@@ ruby
	Vagrant.configure("2") do |config|
		config.vm.hostname = "my-database-berkshelf"
		config.vm.box = "ubuntu-12.04.2-cespi-amd64"
		config.vm.box_url = "http://vagrantbox..."
		config.vm.network :private_network, ip: "33.33.33.10"
		config.ssh.max_tries = 40
		config.ssh.timeout   = 120
		config.berkshelf.enabled = true
		config.vm.provision :chef_solo do |chef|
			chef.json = {
				:mysql => {
					:server_root_password => 'rootpass',
					:server_debian_password => 'debpass',
					:server_repl_password => 'replpass'
				}
			}
			chef.run_list = [
					"recipe[apt]",
					"recipe[mysql::server]",
					"recipe[my_database::default]"
			]
		end
	end

!SLIDE smbullets small transition=scrollVert
# Nos faltan los atributos
Editamos `attributes/default.rb`

	@@@ ruby
	default[:my_database][:name] = "my_database"
	default[:my_database][:user] = "my_user"
	default[:my_database][:password] = "my_password"

Y probamos el cookbook completo con: `vagrant up`

