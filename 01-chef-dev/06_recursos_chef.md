!SLIDE subsection center transition=scrollVert
# Resources en Chef

!SLIDE smbullets small transition=scrollVert
# Resources en Chef
* Son la parte **fundamental** de los recipes
* Define las acciones a tomar:
  * Cuándo instalar un paquete
  * Cuándo un servicio debe iniciarse o reiniciarse
  * Qué usuarios, grupos o membresías deben crearse
* Cuando Chef corre, cada resource es identificado y asociado con un **provider**
  * El proveedor es quien realiza el trabajo que define el resource
* Chef **asegura** que:
  * Las mismas acciones son realizadas de la misma forma cada vez 
  * Las acciones siempre producen los mismos resultados
  
!SLIDE smbullets transition=scrollVert
# Resources en Chef

* Los resources se implementan dentro de recipes usando ruby
* Un resource representa alguna parte del sistema (y su estado deseado)
  * Un provider ofrece las herramientas para llevar a ésta parte del sistema desde
  su estado actual, al estado deseado
* A partir de [Ohai](http://docs.opscode.com/ohai.html) (herramienta utilizada
  para detectar propiedades de un sistema como procesador, plataforma, SO,
memoria, etc):
  * Chef verifica `platform` y `platform_version` para identificar el provider
    adecuado 
!SLIDE smaller transition=scrollVert
# Resources en Chef

## Ejemplo de un resource

	@@@ ruby
	directory "/tmp/folder" do
	  owner "root"
	  group "root"
	  mode 0755
	  action :create
	end

* Chef buscará el provider para `directory resource` que en este caso es
 `Chef::Provider::Directory`
* En base al resource mostrado, que resulta llamarse `directory["/tmp/folder"]`
  * Analiza el estado actual del recurso
  * Realiza la acción mencionada: `:create`
* Si el directorio ya existía, no hace nada, sino lo creará con los permisos,
  dueño y grupo mencionados

!SLIDE smbullets transition=scrollVert
# Resources en Chef

## O sea...

* Los recursos son parte de la DSL de Chef
* Se van a usar de la forma mostrada con el ejemplo `directory`, como si fuesen un bloque de ruby
* Dentro del bloque del resource, se especificarán los atributos que defina ese
  resource
* El provider hará su trabajo de forma mágica

!SLIDE smbullets transition=scrollVert
# Funcionalidad común de todos los resources

## Acciones

* Todos los recursos admitirán acciones a través del atributo `action`.
* Todos los resources soportan el **action** `:nothing`
  * Se utiliza para especificar que el recurso no hace nada. En ausencia de otra
    acción espeficada para un resource por defecto, se utiliza `:nothing` por
default

!SLIDE smbullets transition=scrollVert
# Ejemplo de uso de action
## Ejemplo de uso del action `:nothing`

	@@@ ruby
	service "memcached" do
		action :nothing
		supports {
			:status => true, 
			:start => true, 
			:stop => true, 
			:restart => true
		}
	end

!SLIDE smbullets smaller transition=scrollVert
# Más funcionalidad común de todos los resources

* `ignore_failure`: utilizado para que la ejecución de un recipe continúe incluso ante la falla del recurso. Su valor por defecto es `false`
* `provider`: utilizado para especificar el provder. Generalmente no es necesario. El nombre debe ser el nombre copleto de la clase que lo implementa. Por ejemplo: ` provider Chef::Provider::Long::Name`. 
* `retries`: usado para especificar el número de veces que debe catchearse excepciones y reintentar con el resource.. El valor por defecto es `0`
* `retry_delay`: usado para especificar el delay de retardo entre reintentos en segundos. El valor por defecto es: `2`
* `supports`: usado para especificar un Hash de opciones que contienen los *hints* sobre las capacidades del resource. Chef puede itilizar estos *hints* para ayudarse a identificar el provider adecuado. Este atributo lo utiliza una pequeña cantidad de providers, incluyendo *users* y *service*.

!SLIDE small transition=scrollVert
# Ejemplo de uso de action
## Ejemplo de ignore failure

	@@@ ruby
	gem_package "syntax" do
		action :install
		ignore_failure true
	end

## Ejemplo de provider

	@@@ ruby
	package "some_package" do
		provider Chef::Provider::Package::Rubygems
	end

!SLIDE smbullets transition=scrollVert
# Ejecución condicional

* La ejecución condicional permite agregar guardas a la ejecución de un resource
* Esto permite agergar condiciones antes de ejecutar el resource
* La razón de ser de esto, es que debemos garantizar que la ejecución de un resource **siempre** produce el mismo resultado
* La condición podrá pasarse como **string** o como **bloque**
  * **strings:** se ejecutan como un comando de shell
  * **bloques:** se ejecutan como código Ruby
* En el caso de strings el atributo será `true` cuando retorne `0`

!SLIDE bullets transition=scrollVert
# Ejecución condicional

* Atributos que permiten la ejecución condicional
  * `not_if`
  * `only_if`

!SLIDE bullets transition=scrollVert
# Ejecución condicional

* En ambos casos, es posible utilizar argumentos:
  * `:user`: usado para especificar el usuario con el que se correrá el comando a evaluar
  * `:group:`: igual que el anterior, pero aplica al grupo
  * `:environment`: un hash de variables de ambiente que serán seteadas
  * `:cwd`: setea el path donde se correrá el comando
  * `:timeout`: para setear un timeout para el comando

!SLIDE small transition=scrollVert
# Ejecución condicional
## Ejemplo de uso de argumentos

	@@@ ruby
		not_if "grep adam /etc/passwd", :user => 'adam'

		not_if "grep adam /etc/passwd", :group => 'adam'

		not_if "grep adam /etc/passwd", {
			:environment => { 'HOME' => "/home/adam" }
		}

		not_if "grep adam passwd", :cwd => '/etc'

		not_if "sleep 10000", :timeout => 10


!SLIDE small transition=scrollVert
# Ejecución condicional
## Ejemplo de ejecución condicional completo

	@@@ ruby
	template "/tmp/somefile" do
		mode 00644
		source "somefile.erb"
		not_if {File.exists?("/etc/passwd")}
	end

	template "/tmp/somefile" do
		mode 00644
		source "somefile.erb"
		not_if "test -f /etc/passwd"
	end

!SLIDE bullets small transition=scrollVert
# Notificaciones

Permite que los resources se notifiquen o suscriban a ser notificados de cambios
en otros resources

* Cualquier resource puede utilizar las siguientes notificaciones
  * `notifies`: utilizado para notificar a otros resources cambios 
  * `subscribes`:  utilizado para ser notificado ante cambios en otros resources
* Pueden utilizarse timers
  * `delayed`: indica que la notificación será encolada i ejecutada al final de
    la cola de tareas a realizar po el Chef run 
  * `immediately`: indica que la notificación deberá correrse inmediatamente

!SLIDE smaller transition=scrollVert
# Notificaciones
## La sintaxis

	@@@ ruby
	resource "name" do
		notifies :action, "res_type[res_name]", :notif_timing
	end

	resource "name" do
		subscribes :action, "res_type[res_name]", :notif_timing
	end

!SLIDE smaller transition=scrollVert
# Notificaciones
## Ejemplo de reiniciar un servicio 

	@@@ ruby
	template "/etc/www/configures-apache.conf" do
		notifies :restart, "service[apache]"
	end

## Ejemplo de notificar varios
	@@@ ruby
	template "/etc/chef/server.rb" do
		source "server.rb.erb"
		owner "root"
		group "root"
		mode "644"
		notifies :restart, "service[chef-solr]", :delayed
		notifies :restart, "service[chef-solr-indexer]", :delayed
		notifies :restart, "service[chef-server]", :delayed
	end

!SLIDE smbullets smaller transition=scrollVert
# Resources disponibles
* apt_packages
* bash
* breakpoint
* chef_gem
* cookbook_file
* cron
* csh
* deploy
* directory
* dpkg_package
* easy_install_package
* env

!SLIDE smbullets smaller transition=scrollVert
# Resources disponibles
* erl_call
* execute
* file
* freebsd_package
* gem_package
* git
* group
* htt_request
* ifconfig
* ips_package
* link
* log
* macports_package

!SLIDE smbullets smaller transition=scrollVert
# Resources disponibles
* mdmadm
* mount
* ohai
* package
* pacman
* perl
* portage_package
* powershell_script
* python
* registry_key
* remote_directory
* remote_file
* route
* rpm_package

!SLIDE smbullets smaller transition=scrollVert
# Resources disponibles
* ruby
* ruby_block
* scm
* script
* service
* smartos_package
* solaris_package
* subversion
* template
* user
* yum_package

!SLIDE smbullets transition=scrollVert
# Resources disponibles
## Documentación disponible en:

[http://docs.opscode.com/resource.html](http://docs.opscode.com/resource.html)

