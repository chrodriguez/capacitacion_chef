!SLIDE subsection center transition=scrollVert
# Roles

!SLIDE smbullets transition=scrollVert
# Roles
* Forma de definir determinados patrones y procesos 
* Un role es un conjunto de cero o más `atributtes` y un `run_lists`
* Un nodo podrá tener cero o más roles asignados
* Los atributos del nodo serán calculados y mezclados al inicio de cada corrida
  de Chef, considerando las precedencias de los mismos

!SLIDE smbullets transition=scrollVert
# Roles Attributes

* Un attribute puede definirse en un role y luego es utilizado para sobreescribir el
  valor por defecto en un node.
* En cada corrida de Chef, estos attributes son comparados con los ya
  disponibles en el node.
  * Cuando la precedencia de los attributes en el role, tengan mayor precedencia
    que los del node, entonces Chef aplicará estos nuevos valores durante la
    corrida de Chef
* Un role attribute podrá ser:
  * `default` attribute
  * `override` attribute
* Nunca un role, podrá definir un `normal` attribute

!SLIDE smbullets transition=scrollVert
# Formato de los Roles

* Los roles podrán definirse usando:
  * **DSL Ruby**: se escriben en ruby, pero se convierten en JSON al subirse al
    repositorio Chef. 
  * **JSON**: este formato mapea directamente con lo que veamos para la DSL de
    Ruby. No será necesario compilarlo como sucede con Ruby antes de subirlo al
    repositorio Chef

!SLIDE smbullets smaller transition=scrollVert
# Roles usando Ruby DSL
Un archivo de role, usando Ruby DSL debe tener extensión `.rb` y estar dentro
del directorio `roles/` del repositorio Chef

* `default_attributes`: opcional. Hash de attributes a aplicar a un node,
  asumiendo que el node no dispone de un valor para estos attributes. Si más de
un role, hacen referencia al mismo valor, el último aplicado ganará
* `description`: texto que describe la función del role
* `env_run_lists`: permite definir `run_lists` por environments. En caso de
  usarse, es un override del attributo `run_lists` explicado más adelante
* `name`: nombre del role que debe ser único en todo el ecosistema de Chef. El
  nombre puede formarse de letras (minúsculas y mayúsuclas), números, guión
  bajo, y guión medio: `[A-Z][a-z][0-9] and [_-]`
* `override_attributes`: opcional. Hash de attributes a aplicar a un node,
  incluso si el node ya dispone de estos valores para estos attributes. Aplica
  la misma regla que para el caso `default_attributes`
* `run_list`: lista de recipes y/o roles a aplicar en el orden provisto

!SLIDE smaller transition=scrollVert
# Ejemplo de un role

	@@@ ruby
	name "webserver"
	description "base role for systems that serve HTTP traffic"
	run_list ("recipe[apache2]", "recipe[apache2::mod_ssl]", 
	          "role[monitor]")
	env_run_lists(
		"prod" => ["recipe[apache2]"], 
		"staging" => ["recipe[apache2::staging]"], 
		"_default" => [])
	default_attributes(
		"apache2" => { "listen_ports" => [ "80", "443" ] })
	override_attributes( 
		"apache2" => { "max_children" => "50" })

!SLIDE smbullets smaller transition=scrollVert
# El mismo role usando JSON

Podemos ver que el formato JSON agrega dos atributos: `chef_type` y `json_class`

	@@@ json
	{
		"name": "webserver",
		"chef_type": "role",
		"json_class": "Chef::Role",
		"default_attributes": {
			"apache2": {
				"listen_ports": [
					"80",
					"443"
				]
			}
		},
		"description": "base role for systems that serve HTTP",
		"run_list": [
			"recipe[apache2]",
			"recipe[apache2::mod_ssl]",
			"role[montior]"
		],
		...
		...
!SLIDE smbullets smaller transition=scrollVert
# El mismo role usando JSON
	@@@ json
		...
		...
		"env_run_lists" : {
			"production" : [],
			"preprod" : [],
			"dev": [
				"role[base]",
				"recipe[apache]",
				"recipe[apache::copy_dev_configs]",
			],
			 "test": [
				"role[base]",
				"recipe[apache]"
			]
		 },
		"override_attributes": {
			"apache2": {
				"max_children": "50"
			}
		}
	}

!SLIDE smbullets transition=scrollVert
# Manejo de roles

* Chef provee diversas formas de gestionar los roles en un ambiente de
	producción y distribuido como veremos más adelante
* Para el caso de uso con Vagrant, pueden usarse roles que se configuran desde
	`Vagrantfile`
