!SLIDE subsection center transition=scrollVert
# Environments

!SLIDE smbullets small transition=scrollVert
# Environments
* Permite mapear ambientes reales en configuraciones que manejará Chef
* En el ecosistema de Chef, siempre existirá un environment llamado `_default`
  * No podrá modificarse
  * No podrá eliminarse
* Se podrán crear tantos environments como se desee, por ejemplo:
  * Production
  * Testing
  * Staging
  * Development
* Generalmente se asocia a un environment las **versiones de cookbooks**


!SLIDE smbullets transition=scrollVert
# El environment _default

* Esto garantiza que cualquier corrida de Chef cuenta con un environment
* No podrá modificarse de ninguna forma
* Cualquier attribute o cookbook a restringir que desee asociarse a este environment no
  podrá hacerse.
  * Solo será posible creando nuevos environments

!SLIDE smbullets transition=scrollVert
# Environment Attributes

* Un attribute puede definirse en un environment y luego es utilizado para sobreescribir el
  valor por defecto en un node.
* En cada corrida de Chef, estos attributes son comparados con los ya
  disponibles en el node.
  * Cuando la precedencia de los attributes en el environment, tengan mayor precedencia
    que los del node, entonces Chef aplicará estos nuevos valores durante la
    corrida de Chef
* Un environment attribute podrá ser:
  * `default` attribute
  * `override` attribute
* Nunca un role, podrá definir un `normal` attribute

!SLIDE smbullets transition=scrollVert
# Formato de los Environments

* Los environments podrán definirse usando:
  * **DSL Ruby**: se escriben en ruby, pero se convierten en JSON al subirse al
    repositorio Chef. 
  * **JSON**: este formato mapea directamente con lo que veamos para la DSL de
    Ruby. No será necesario compilarlo como sucede con Ruby antes de subirlo al
    repositorio Chef

!SLIDE smbullets smaller transition=scrollVert
# Environments usando Ruby DSL
Un archivo de environments, usando Ruby DSL debe tener extensión `.rb` y estar dentro
del directorio `environments/` del repositorio Chef

* `cookbook`: Una restricción sobre la versión de un cookbook específico
* `cookbook_versions`: Una restricción sobre la versión de un grupo de cookbooks
* `default_attributes`: opcional. Hash de attributes a aplicar a un node,
  asumiendo que el node no dispone de un valor para estos attributes
* `description`: texto que describe la función del environment
* `name`: nombre del environment que debe ser único en todo el ecosistema de Chef. El
  nombre puede formarse de letras (minúsculas y mayúsuclas), números, guión
  bajo, y guión medio: `[A-Z][a-z][0-9] and [_-]`
* `override_attributes`: opcional. Hash de attributes a aplicar a un node,
  incluso si el node ya dispone de estos valores para estos attributes

!SLIDE smaller transition=scrollVert
# Ejemplo de un environment

	@@@ ruby
	name "dev"
	description "The development environment"
	cookbook_versions  "couchdb" => "= 11.0.0"
	default_attributes(
		"apache2" => { 
			"listen_ports" => [ "80", "443" ] 
		})

!SLIDE smbullets smaller transition=scrollVert
# El mismo role usando JSON

Podemos ver que el formato JSON agrega dos atributos: `chef_type` y `json_class`

	@@@ json
	{
		"name": "dev",
		"default_attributes": {
			"apache2": {
				"listen_ports": [
					"80",
					"443"
				]
			}
		},
		"json_class": "Chef::Environment",
		"description": "",
		 "cookbook_versions": {
			"couchdb": "= 11.0.0"
		},
		"chef_type": "environment"
	}

!SLIDE smbullets transition=scrollVert
# Manejo de environments

* Chef provee diversas formas de gestionar los roles en un ambiente de
	producción y distribuido como veremos más adelante
* Para el caso de uso con Vagrant, pueden usarse environments que se configuran desde
	`Vagrantfile`
