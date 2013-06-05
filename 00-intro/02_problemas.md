!SLIDE bullets transition=scrollVert
# Los problemas

* Los problemas pueden verse desde:
  * La perspectiva de desarrollo
  * La perspectiva de soporte
  * La perspectiva de producción

!SLIDE smbullets transition=scrollVert
# Los problemas desde la visión de desarrollo

* Versiones de productos todas las semanas
* Por día se hacen alrededor de 5 deploys: 
  * *Por errores en producción*
  * *Por nuevas funcionalidades solicitadas*
* Ambientes de trabajo:
  * Desarrollo
  * Pruebas
  * *Preproducción*
  * Producción

!SLIDE smbullets transition=scrollVert

# Más problemas desde la visión de desarrollo
* Ambientes complejos:
  * **SSO** 
  * **API** 
  * **Balanceo y cache** 
* Conseguir elementos en producción
  * Dumps en producción
  * Código en producción

!SLIDE smbullets transition=scrollVert
# Los problemas desde la visión de soporte

* Desarrollo no es el único cliente
* Se cumplen muchas otras tareas complejas
* Los recursos de soporte deben configurar servicios o arquitecturas que no
  definieron o desconocen (API, desarrollos basados en Ruby, Erlang, NodeJS)
* Seguridad comprometida al hostear aplicaciones propias o de terceros
* Manejo de acceso a los servidores
* Vencimientos de SSL

!SLIDE smbullets transition=scrollVert

# Los problemas desde la visión de producción

* Qué tener en cuenta para instalar nuevas aplicaciones
* Qué hacer para actualizar una aplicación
* Cómo aplicar un parche en una base de datos grande que se encuentra en
  producción
* Notificar a usuarios finales del servicio
* Páginas de error ante problemas
* Monitoreo y backup constante de los servicios
* Vencimiento de los contratos

