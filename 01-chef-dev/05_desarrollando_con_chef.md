!SLIDE subsection center transition=scrollVert
#Desarrollando con Chef

!SLIDE smbullets transition=scrollVert
# Desarrollando con Chef
* Se respeta una filosofía muy instaurada en la comunidad Ruby
	* **Convention over configuration**
* Todos los cookbooks tienen la misma estructura

!SLIDE commandline transition=scrollVert
# Estructura de un cookbook

	$ tree -d mis_cookbooks/mi_cookbook
	 ├── attributes
	 ├── definitions
	 ├── files
	 ├── libraries
	 ├── providers
	 ├── recipes
	 ├── resources
	 └── templates
	
!SLIDE smbullets small transition=scrollVert
# Estructura de un cookbook
* Los **recipes** se guardan en el directorio `recipes`. Y su nombre es importante:
  * **recipe[ntp::foo]:** `mis_cookbooks/ntp/recipes/foo.rb`
  * **recipe[ntp]:** `mis_cookbooks/ntp/recipes/default.rb`
* El nombre de un recipe debe especificar el nombre del cookbook definendo así un **namespace**

!SLIDE commandline incremental transition=scrollVert
# Mi primer recipe

Creamos el directorio para el `cookbook` y `recipe`
 
	$ mkdir -p prueba_chef/cookbooks/test/recipes

!SLIDE small transition=scrollVert
# Mi primer recipe

Creamos el archivo `prueba_chef/cookbooks/test/recipes/default.rb` con el siguiente contenido:

	@@@ ruby
	user "ejemplo" do
	  home '/home/ejemplo'
	  shell '/bin/bash'
	  password 'STHx70ea82L.Yw1eAha15.'
	  # calculada con: 
	  #   openssl passwd -1 "pass_de_ejemplo"
	end

!SLIDE commandline incremental smaller transition=scrollVert
# Lo probamos usando Vagrant

Ubicados dentro del directorio raiz `prueba_chef/` corremos

	$ vagrant init ubuntu-1204 \
		 http://vagrantbox.desarrollo.cespi.unlp.edu.ar/pub/ubuntu-12.04.2-cespi-amd64.box
	A `Vagrantfile` has been placed in this directory. You are now
	ready to `vagrant up` your first virtual environment! Please read
	the comments in the Vagrantfile as well as documentation on
	`vagrantup.com` for more information on using Vagrant.
	
	$ vagrant up
	Bringing machine 'default' up with 'virtualbox' provider...
	[default] Box 'opscode-ubuntu-1204' was not found. Fetching box from specified
	URL for the provider 'virtualbox'. Note that if the URL does not have
	a box for this provider, you should interrupt Vagrant now and add
	the box yourself. Otherwise Vagrant will attempt to download the
	full box prior to discovering this error.
	Downloading or copying the box...
	Extracting box...te: 4563k/s, Estimated time remaining: 0:00:01)
	Successfully added box 'opscode-ubuntu-1204' with provider 'virtualbox'!
	[default] Importing base box 'opscode-ubuntu-1204'...
	[default] Matching MAC address for NAT networking...
	[default] Setting the name of the VM...
	[default] Clearing any previously set forwarded ports...
	[default] Creating shared folders metadata...
	[default] Clearing any previously set network interfaces...
	[default] Preparing network interfaces based on configuration...
	[default] Forwarding ports...
	[default] -- 22 => 2222 (adapter 1)
	[default] Booting VM...
	[default] Waiting for VM to boot. This can take a few minutes.

