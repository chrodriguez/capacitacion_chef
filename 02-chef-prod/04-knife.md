!SLIDE center subsection transition=scrollVert
# Knife

!SLIDE smbullets transition=scrollVert
# Bootstrap de un nodo

* Se llama *bootstrap de un nodo* a la instalación de chef en el nodo y 
  registración ante Chef Server
* Para llevar a cabo este procedimiento, debemos:
  * Conocer de antemano el **FQDN** o **dirección IP** del nuevo nodo
  * Correr el comando `knife bootstrap`
  * Verificar el nodo en Chef Server

!SLIDE smbullets small transition=scrollVert
# Corriendo el comando knife bootstrap
* El comando `knife bootstrap` requiere la dirección IP o FQDN de un nodo
* Una vez ejecutado el comando, se realiza una conexión ssh al nodo donde:
  * Instalará `chef-client` si es necesario
  * Generará claves
  * Registrará el nodo con Chef Server
* Para realizar la primer conexión se requerirá:
  * Usuario y clave ssh o archivo de identidad
  * Acceso como root al nodo
  * Y si el sistema destino **no es Ubuntu** debemos indicar el SO por única vez
* Un ejemplo:

  `$  knife bootstrap 123.45.6.789 -x username -P password --sudo`

!SLIDE commandline transition=scrollVert
# Verificando el nodo

Opcionalmente, luego de realizar un `bootstrap` es conveniente verificar si
Chef Server conoce al nuevo nodo:

	$ knife client show node_name
	admin:       false
	chef_type:   client
	json_class:  Chef::ApiClient
	name:        name_of_node
	public_key:

Donde, `node_name` es el nombre del nodo recientemente creado


!SLIDE commandline transition=scrollVert
# Verificando el nodo

Además podemos verificar todos los nodos registrados con Chef Server, usando
knife:

	$ knife client list
	workstation
	workstation
	...
	client
	...
	node_name
	...
	client

!SLIDE small smbullets transition=scrollVert
# Subcomandos knife

* `client`: manipula los clientes de la API, es decir nodos que emplean
   *chef-client* y workstations que usan *knife*
* `configure`: utilizado para crear los archivos `knife.rb` y `client.rb` a ser
   distribuidos a workstations y nodos
* `cookbook`: usado para interactuar con cookbooks ubicadas en Chef Server o
  chef-repo
* `cookbook site`: permite interactuar con cookbooks ubicadas en
  [https://cookbooks.opscode.com/](https://cookbooks.opscode.com/)
* `data bag`: manipula data bags 
* `delete`: elimina un objeto de Chef Server
* `diff`: compara diferencias entre archivos del chef repo y Chef Server
* `download`: permite descargar de Chef Serer en chef repo *roles*, *cookbooks*,
  *environments*, *nodes* y *data bags* 

!SLIDE small smbullets transition=scrollVert
# Subcomandos knife
* `environment`: manejo de environments
* `exec`: ejecuta scripts ruby en el contexto de un chef-client completamente 
  configurado
* `index rebuild`: reindexa el Chef Server. La operación es destructiva y puede
  tardar un poco
* `list`: ver lista de objetos en Chef Server 
* `node`: manipula nodes en Chef Server
* `raw:` envía requerimientos RAW a la API de Chef Server 
* `recipe list`: permite listar todas las recipes disponibles, incluso
  utilizando filtros
* `role`: manejo de roles en Chef Server

!SLIDE small smbullets transition=scrollVert
# Subcomandos knife
* `search`: búsquedas sobre elementos indexados por Chef Server
* `show`: visualizar detalles de uno o más objetos en Chef Server
* `ssh`: invoca comandos SSH (en parelelo) en un subconjunto de nodos dentro de
  una organización, basándose en resultados de búsqueda
* `status`: muestra información resumida de los nodes en Chef Server, incluyendo
  el tiempo de la última corrida exitosa de chef-client.
* `tag`: permite aplicar y manipular tags sobre nodes
* `upload`: permite cargar *roles*, *cookbooks*, *ambientes* y *data bags* al
  chef Server
* `user`: manejo de usuarios y pares de claves públicas RSA

!SLIDE smaller transition=scrollVert
# Plugins de knife
* Povistos por Opscode
  * **azure:** integra con Microsoft Azure
  * **bluebox:** integra con BlueBox
  * **ec2:** Amazon EC2
  * **eucalyptus:** simplifica la gestión de servidores hosteados utilizando
    Eucalyptus
  * **google:** se integra con Google Compute Engine 
  * **hp:** HP Cloud Compute
  * **linode:** se integra con Linode cloud
  * **openstack:** clouds OpenStack
  * **rackspace:** integración con rackspace
  * **terremark:** se integra con Terremark
  * **windows:** configura e interactúa con nodes Windows. Para ello utiliza
    Windows Remote Management, que permite a objetos nativos (como scripts
batch, scripts en Powershell, etc) ser llamados desde aplicaciones externas

!SLIDE smaller transition=scrollVert
# Plugins de knife
* Plugins comunitarios más conocidos
  * **knife-essentials:** agrega la posibilidad de manipular knife con verbos como
    si operara sobre un filesystem
  * **knife-cloudstack / knife-cloudstack-fog:** bootstrap integrado con
    Cloudstack
  * **knife-esx:** bootstrap integrado con VMWare 
  * **knife-ipmi:** simple manejo de power usando IPMI
  * **knife-rvc:** integra un subconjunto de la funcionalidad de knife con
    vSphere
  * **knife-spork:** workflows para el manejo de cookbooks y ambientes en teams
    de varios integrantes
* Más plugins en [Docs Opscode](http://docs.opscode.com/community_plugin_knife.html)

!SLIDE center subsection small transition=scrollVert
![saca-lengua](saca-lengua.png)
# ¡¡Gracias a todos por organizar el ASADO de mañana!!
