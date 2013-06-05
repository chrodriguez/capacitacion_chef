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
  * Iptables por usuario de aplicacion

!SLIDE smbullets transition=scrollVert
# Configuraciones de Apache con VHosts por usuario

* Surgieron nuevas alternativas
  * Nginx
  * FPM PHP
* Problemas?
  * Gestionar usuarios para cada aplicacion
  * Distintos ambientes: testing, producción
  * Y las aplicaciones ruby y Java
