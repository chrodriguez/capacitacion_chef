!SLIDE subsection center transition=scrollVert
# Data Bags

!SLIDE smbullets small transition=scrollVert
# Data Bags
* Un data bag es una variable global 
* Es almacenada como JSON
* Es accesible mediante el servidor Chef
* Los data bags son indexados para realizar búsquedas
* Pueden accederse desde: 
  * Recipes
  * Durante una búsqueda
* Los datos almacenados en un data bag varían
  * Generalmente se incluye información sensible: *password de base de datos*

!SLIDE smbullets transition=scrollVert
# Creando Data Bags

* Podemos crear un data bag usando:
  * El comando `knife` como veremos más adelante
  * Creando un directorio bajo la carpeta `data_bags` con el nombre del `bag` y
    dentro del mismo un archivo con el nombre del `item` y extensión `.json`

!SLIDE commandline incremental transition=scrollVert
# Creando Data Bags

	$ mkdir data_bags
	$ mkdir data_bags/admins
	$ vi data_bags/admins/car.json

!SLIDE small transition=scrollVert
# La estructura de directorios

	@@@ sh
	data_bags
	 |_admins
			|_charlie.json
			|_bob.json
			|_tom.json
	 |_db_users
			|_charlie.json
			|_bob.json
			|_sarah.json
	 |_db_config
			|_small.json
			|_medium.json
			|_large.json

donde `_admins`, `_db_users` y `_db_config` son nombres de data bags individuales, y todos los archivos que terminan con `.json` son ítems individuales

!SLIDE smbullets transition=scrollVert
# Data Bag Items

* Un data bag ítem es un contenedor de datos, donde cada uno es un archivo JSON
* El único requerimiento estructural de un ítem es que tenga un `id`

## Ejemplo:

	@@@ json
	{
		"id": "ITEM_NAME"
		"key": "value"
	}

!SLIDE smbullets transition=scrollVert
# Data Bags encriptados

* El contenido de un data bag puede encriptarse usando una [encripción de clave compartida](https://en.wikipedia.org/wiki/Symmetric-key_algorithm)
* Esto permite a los data bags almacenar información confidencial
* Lo veremos más en detalle cuando trabajemos usando knife

!SLIDE smbullets transition=scrollVert
# Usando Data Bags
* Es posible buscar sobre los data bags almacenados en el server Chef
  * No nos sirve si usamos chef-solo
* Leyendo directamente del data bag que necesitemos

!SLIDE small transition=scrollVert
# Usando Data Bags

El siguiente ejemplo lee todos los items del data bag admins creando cada
usuario

	@@@ ruby
	admins = data_bag('admins')
	admins.each do |login|
		admin = data_bag_item('admins', login)
		home = "/home/#{login}"

		user(login) do
			uid       admin['uid']
			gid       admin['gid']
			shell     admin['shell']
			comment   admin['comment']
			home      home
			supports  :manage_home => true
		end
	end

!SLIDE commandline incremental transition=scrollVert
# Hagamos este ejemplo

Creamos un directorio para el data bag `admins` y un nuevo cookbook para esta prueba: **my_databag**

	$ mkdir -p data_bags/admins
	$ berks cookbook my_database
		create  my_databag/files/default
		create  my_databag/templates/default
		create  my_databag/attributes
		create  my_databag/definitions
		create  my_databag/libraries
		create  my_databag/providers
		create  my_databag/recipes
		create  my_databag/resources
		create  my_databag/recipes/default.rb
		create  my_databag/metadata.rb
		create  my_databag/LICENSE
		create  my_databag/README.md
		create  my_databag/Berksfile
		create  my_databag/chefignore
		create  my_databag/.gitignore
			 run  git init from "./my_databag"
		create  my_databag/Gemfile
		create  my_databag/Vagrantfile

!SLIDE smbullets smaller transition=scrollVert
# Creamos los data bag items
Bajo el directorio `data_bags/admins` creamos los archivos
## `juan.json`
	@@@ json
	{
		"id": "juan",
		"uid": 5000,
		"gid": "users",
		"shell": "/bin/bash",
		"comment": "Este usuario es Juan"
	}

## `pedro.json`
	@@@ json
	{
		"id": "pedro",
		"uid": 5001,
		"gid": "users",
		"shell": "/bin/bash",
		"comment": "Este usuario es Pedro"
	}
!SLIDE smaller transition=scrollVert
# La receta que crea los usuarios

Copiamos el ejemplo dado anteriormente bajo `recipes/default.rb`

	@@@ ruby
	admins = data_bag('admins')
	admins.each do |login|
		admin = data_bag_item('admins', login)
		home = "/home/#{login}"

		user(login) do
			uid       admin['uid']
			gid       admin['gid']
			shell     admin['shell']
			comment   admin['comment']
			home      home
			supports  :manage_home => true
		end
	end

!SLIDE smaller transition=scrollVert
# Editamos el Vagrantfile

El `Vagrantfile` debe quedar así:

	@@@ ruby
	Vagrant.configure("2") do |config|
		config.vm.hostname = "my-databag-berkshelf"
		config.vm.box = "ubuntu-12.04.2-cespi-amd64"
		config.vm.box_url = "http://vagrantbox.de.."
		config.vm.network :private_network, ip: "33.33.33.20"
		config.ssh.max_tries = 40
		config.ssh.timeout   = 120
		config.berkshelf.enabled = true
		config.vm.provision :chef_solo do |chef|
			chef.data_bags_path = "../data_bags"
			chef.json = {
				:mysql => {
					:server_root_password => 'rootpass',
					:server_debian_password => 'debpass',
					:server_repl_password => 'replpass'
				}
			}
			chef.run_list = [
					"recipe[my_databag::default]"
			]
		end
	end

