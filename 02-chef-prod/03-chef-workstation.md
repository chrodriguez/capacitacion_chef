!SLIDE center subsection transition=scrollVert
# Workstation

!SLIDE smbullets transition=scrollVert
# Prerequisitos para instalar el Workstation

* Disponer de acceso a un Chef Server
  * Usaremos el ejemplo dado anteriormente
  * Podríamos usar Hosted Chef Server
* Es aconsejable utilizar *[chef-repo](https://github.com/opscode/chef-repo)*
  * Empleando `git` para versionarlo en un servidor propio de GIT o forkeando en
    github
* Instalar chef en nuestra máquina (en el workstation)
* Copiar desde el Chef Server `/etc/chef-server/chef-validation.pem` a nuestro
	workstation

!SLIDE commandline small transition=scrollVert
# Instalando prerequisitos

Asumiendo que ya decidimos qué Chef Server usamos y sin importar si usamos o no
*chef-repo* aun, instalamos chef

	$ mkdir -p workstation/.chef
	$ cd workstation
	$ bundle init
	Writing new Gemfile to ....


!SLIDE transition=scrollVert
# Instalando prerequisitos

## Editamos el `Gemfile`

	@@@ruby
	# A sample Gemfile
	source "https://rubygems.org"
	
	gem "chef"

Corremos luego `bundle`

!SLIDE bullets small transition=scrollVert
# Instalando prerequisitos

## Obteniendo los certificados
* Copiamos dentro del directorio `.chef` el archivo `chef-validation.pem` desde el
  Chef Server
  * Por lo general, en Chef Server este archivo está en `/etc/chef-server`
* Accedemos además al Chef Server Web UI con el usuario **admin** y obtenemos
  la clave pribada de admin: `admin.pem` que copiamos en `/tmp/admin.pem`
  * Si no queremos usar Web UI, podemos seguir los mismos pasos que para
    `validation.pem`, el certificado del usuario admin, está generalmente en el
    mismo directorio

!SLIDE commandline small transition=scrollVert
# Configurando el Workstation

## Configuramos por primera vez

	$ touch .chef/knife.rb
	$ bundle exec knife configure --initial
	/xxxx/workstation/.chef/knife.rb?  (Y/N) 
		y

	Please enter the chef server URL: [http://yourhostname:4000] 
		https://chef-server-berkshelf/

	Please enter a name for the new user: [car] 
	Please enter the existing admin name: [admin] 
	Please enter the location of the existing admin's private key: [/etc/chef/admin.pem] 
		/tmp/admin.pem

	Please enter the validation clientname: [chef-validator] 
	Please enter the location of the validation key: [/etc/chef/validation.pem] 
		/xxx/workstation/.chef/chef-validation.pem

	Please enter the path to a chef repository (or leave blank): 
	Creating initial API user...
	Please enter a password for the new user: 
	Created user[car]

Luego podemos eliminar `/tmp/admin.pem`

!SLIDE commandline incremental transition=scrollVert
# Verificando el Workstation

## Utilizamos `knife`

	$ knife client list
	chef-validator
	chef-webui
	
	$ knife user list
	admin
	SU USUARIO

!SLIDE smbullets small transition=scrollVert
# Usando chef-repo

* Es una estructura de directorios **conveniente** para el trabajo desde un
  workstation
* El repo original es:
  [https://github.com/opscode/chef-repo](https://github.com/opscode/chef-repo)]
* Las pruebas que hicimos con `knife` anteriormente fueron en un directorio que
  sólo contiene:
  * `Gemfile`
  * `.chef/`

* Podemos forkear el repositorio de Opscode en Github y crear nuestro propio
  `chef-repo`
* Clonamos nuestro propio `chef-repo` en algún directorio y copiamos la
  configuracion que habíamos hecho para `knife`

!SLIDE commandline transition=scrollVert
# Usando chef-repo

Asumiendo que el `Gemfile` y `.chef/` se encuentran en `/undir`

	$ git clone https://github.com/MIUSER/chef-repo
	Cloning into 'chef-repo'...
	remote: Counting objects: 213, done.
	remote: Compressing objects: 100% (131/131), done.
	remote: Total 213 (delta 76), reused 173 (delta 48)
	Receiving objects: 100% (213/213), 36.90 KiB, done.
	Resolving deltas: 100% (76/76), done.
	
	$ cd chef-repo
	$ cp -pr /undir/Gemfile /undir/.chef .
	$ bundle
	$ knife user list

!SLIDE smbullets ransition=scrollVert
# Usando chef-repo
* Cada workstation de Chef **requiere un chef-repo**
* En este repositorio existen los cookbooks, roles, archivos de configuración,
  etc. usados para manipular Chef
* Se recomienda que utilizar algún SCM para versionar este directorio

!SLIDE smbullets small ransition=scrollVert
# Directorios de chef-repo

* `certificates/`: certificados SSL generados con `rake ssl_cert`
* `config/`: configuración de las tareas `rake` como por ejemplo la
  configuración usada para generar los certificados SSL
* `cookbooks/`: directorio donde se encuentran los cookbooks descargados o
  creados. Luego veremos que existen gemas que ayudan a gestionar este
  directorio
* `data_bags/`: almancenamiento de data bags en formato .rb y .json. Sirve de backup,
  copia, acceso directo, de lo que realmene está en el Chef Server
* `roles/`: almacenamiento de roles en formato .rb y .json. Sirve de backup,
  copia, acceso directo, de lo que realmente está en el Chef Server

!SLIDE smbullets small ransition=scrollVert
# Tareas rake

* Pueden conocerse todas las tareas rake usando `rake -T`
* Por defecto, la tarea que se corre si no se especifica ninguna es
  `test_cookbooks`
* Las más importantes son:
  * `bundle_cookbook[cookbook]`: crea tarballs de cookbooks en  el directorio `pkgs/`
  * `install`:  llama a las tareas `rake` de `update`, `roles` y `upload_cookbooks`
  * `ssl_cert`: crea certificados SSL autofirmados en el directorio `certificates/`
  * `update`: actualiza el repositorio usando el SCM. Solo entiende `git` y `svn`
* El resto de las tareas mencionadas por `rake -T` se duplican con funcionalidad
  que puede lograrse usando el comando `knife` por lo que probablemente sean
removidas en futuras versiones

