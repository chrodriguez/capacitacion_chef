!SLIDE subsection center transition=scrollVert
#Las soluciones

!SLIDE bullets incremental transition=scrollVert
#Las soluciones

A partir de necesidades se fueron analizando soluciones. Muchas no nos llevaron
a nada, pero nos obligaron a juntarnos de forma interdisciplinaria y pensar en
posibles soluciones

* Así fueron apareciendo:
  * Virtualizacion
  * Matriz de aplicaciones por su seguridad y criticidad
  * Configuraciones de Apache con VHosts por usuario
  * Reglas de IPtables por usuario
  * Nuevos productos: nginx, openvz, varnish
 
!SLIDE smbullets transition=scrollVert
# Virtualización

* Nos ayudó a: 
  * Simplificar el backup
  * Gestión de equipos
  * Migrar en caliente
  * Aprovechar el espacio y recursos
  * Instalación de nuevas máquinas a partir de templates

* Nos complicó en:
  * Mantener las máquinas virtuales
  * El estado real de las virtuales
  * Sin storage no se tienen muchas funcionalidades interesantes

!SLIDE bullets transition=scrollVert
#Matriz de aplicaciones

Creimos que arrancar un relevamiento de aplicaciones por seguridad y criticidad
de los datos, podría ayudarnos a armar ambientes disjuntos.

Esta idea derivó en analizar herramientas para deployar aplicaciones web de
forma aislada.

* Algunas ideas:

  * Apache modulo itk
  * [PHP fpm](http://php-fpm.org/)
  * No todo es xAMP
  * Contenedores: [OpenVZ](http://openvz.org/), [Linux
    Containers](http://lxc.sourceforge.net/)

!SLIDE smbullets transition=scrollVert

# Configuraciones de Apache con VHosts por usuario

* Trabajamos en conjunto entre CeRT, Guarani, Desarrollo y Soporte analizando
alternativas
* Los ambientes no eran los mismos pero todos usabamos Apache, PHP y alguna base
  de datos: Mysql, Postgres o Informix
* Se encontró el modulo [Apache ITK](http://mpm-itk.sesse.net/)

!SLIDE smbullets transition=scrollVert

# Configuraciones de Apache con VHosts por usuario

* Se definieron procedimientos para configurar un Apache seguro y
  estandar:
  * Errores en castellano, con un estilo similar para todas nuestra aplicaciones
  * No revelar la identidad del servidor
  * No permitir ejecuciones de scripts en algunos directorios
  * Evitar que interfieran entre aplicaciones
* Problemas?
  * Gestionar usuarios para cada aplicacion
  * Distintos ambientes: testing, producción
  * Aplicaciones Ruby y Java

!SLIDE bullets smaller transition=scrollVert
# Reglas de iptables por usuario de aplicacion

Ejemplo de la regla por defecto de una aplicación WEB que no use una API o
servicio:

	@@@ sh
	iptables -P OUTPUT DROP
	iptables -P INPUT DROP
	iptables -P FORWARD DROP
	iptables -I INPUT -m state --ESTABLISHED,RELATED -j ACCEPT
	iptables -I INPUT -p tcp --dport 80 -j ACCEPT
	iptables -I OUTPUT -m state --STATE ESTABLISHED,RELATED \
		-j ACCEPT
	iptables -I OUTPUT -m owner --gid-owner webservers \
		-m state --state ESTABLISHED,RELATED -j ACCEPT

* Problemas
  * Manejar qué aplicación se conecta con qué otra
  * Y al migrar una dependencia?

!SLIDE smbullets transition=scrollVert
# Encontramos nuevos productos

* [PHP fpm](http://php-fpm.org/)
* [Nginx](http://nginx.org/)
* [Varnish](https://www.varnish-cache.org/)
* Ruby:
  * [Apache Passenger](https://www.phusionpassenger.com)
  * [Unicorn](http://unicorn.bogomips.org/)
  * [Puma](http://puma.io/)

Necesitamos expertice de nuestros equipos de trabajo en estos productos

!SLIDE smbullets transition=scrollVert
