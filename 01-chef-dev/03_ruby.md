!SLIDE subsection center transition=scrollVert 
[![Ruby](ruby.png)](http://www.ruby-lang.org/es/)
# Fundamentos de ruby

!SLIDE smbullets small transition=scrollVert 
#Fundamentos de ruby

* De origen Japonés
* Lenguaje simple de leer
  * Simple pero potente
* Permite la definición de DSL
  * DSL: Domain Specific Language
* Interpretado, reflexivo, orientado a objetos
* Inspirado en:
  * Sintaxis: Python y Perl
  * Características de programación similares a Smalltalk, y en algunos aspectos a
    LISP, LUA
* Hay muchas implementaciones de máquinas virtuales, las más usadas son:
  * [MRI](http://www.ruby-lang.org/es/)
  * [jRuby](http://jruby.org/)
  * [Rubinius](http://rubini.us/)

!SLIDE execute transition=scrollVert 
# Ejemplo de codigo ruby

	@@@ ruby
	1 + 2           # => 3
	2 * 7           # => 14
	5 / 2           # => 2
	5 / 2.0         # => 2.5
	1 + (2 * 3)     # => 7 

*Ruby siempre retorna un valor. En el caso anterior la ejecución del código
retorna 7 que es la última instrucción*

	@@@ ruby
	result = [1, 2, 3].map { |n| n*7 }

!SLIDE smbullets transition=scrollVert 
# El ambiente

![ambiente](ambiente.png)

* **No conviene instalarlo directamente con apt-get**
* Se utilizan manejadores de máquinas virtuales de Ruby
  * [rvm](https://rvm.io/)
  * [rbenv](http://rbenv.org/)

!SLIDE commandline incremental transition=scrollVert 
# Instalando rvm

	$ \curl -L https://get.rvm.io | bash -s stable
		% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
																	 Dload  Upload   Total   Spent    Left  Speed
	100   184  100   184    0     0    168      0  0:00:01  0:00:01 --:--:--   216
	100 13466  100 13466    0     0   6708      0  0:00:02  0:00:02 --:--:-- 54518
	Downloading RVM from wayneeseguin branch stable
		% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
																	 Dload  Upload   Total   Spent    Left  Speed
	100   124  100   124    0     0    132      0 --:--:-- --:--:-- --:--:--   222
	100 1067k  100 1067k    0     0   171k      0  0:00:06  0:00:06 --:--:--  222k

	Installing RVM to ...

!SLIDE commandline transition=scrollVert 
# Verificamos la instalación de rvm

## Primero debemos reiniciar sesión o 

	$ source .bash_profile

## Verificamos que rvm está instalado:

	$ type cd
	cd: es una función
	cd () 
	{ 
			if builtin cd "$@"; then
					[[ -n "${rvm_current_rvmrc:-}" && "$*" == "." ]] && rvm_current_rvmrc=""
	|| true;
					__rvm_cd_functions_set;
					return 0;
			else
					return $?;
			fi
	}


!SLIDE commandline transition=scrollVert 
# Instalamos ruby 1.9.3 con rvm

## Requiere que el usuario sea sudoer

	$ rvm install 1.9.3
	Searching for binary rubies, this might take some time.
	ruby-1.9.3-p429 - #configure
	ruby-1.9.3-p429 - #download
	ruby-1.9.3-p429 - #validate archive
	ruby-1.9.3-p429 - #extract
	ruby-1.9.3-p429 - #validate binary
	ruby-1.9.3-p429 - #setup
	Saving wrappers to '/home/.../.rvm/wrappers/ruby-1.9.3-p429'........
	ruby-1.9.3-p429 - #importing default gemsets, this may take
	time.......................

	$ rvm list
	rvm rubies

	=* ruby-1.9.3-p429 [ x86_64 ]

	# => - current
	# =* - current && default
	#  * - default

.notes Si no queremos que rvm maneje el manejador de paquetes, podemos deshabilitarlo con: `$ rvm autolibs disable`

!SLIDE commandline transition=scrollVert 
# Rubies disponibles

	$ rvm list known
	# MRI Rubies
	[ruby-]1.8.6[-p420]
	[ruby-]1.8.7[-p371]
	[ruby-]1.9.1[-p431]
	[ruby-]1.9.2[-p320]
	[ruby-]1.9.3-p125
	[ruby-]1.9.3-p194
	[ruby-]1.9.3-p286
	[ruby-]1.9.3-p327
	[ruby-]1.9.3-p362
	[ruby-]1.9.3-p374
	[ruby-]1.9.3-p385
	[ruby-]1.9.3-p392
	[ruby-]1.9.3[-p429]
	[ruby-]1.9.3-head
	[ruby-]2.0.0-rc1
	[ruby-]2.0.0-rc2
	[ruby-]2.0.0-p0
	[ruby-]2.0.0[-p195]
	ruby-head

!SLIDE commandline transition=scrollVert 
# Probando Ruby

## Desde la consola

	$ ruby -e 'user=ENV["USER"]; print "Hola #{user}!!\n"'

## En forma interactiva

	$ irb
	1.9.3-p429 :001 > 2+2
	 => 4 

!SLIDE execute transition=scrollVert 
# Un poco de Ruby

## Comentarios

	@@@ ruby
	#Este es un comentario

## Asignación

	@@@ ruby
	x = 1

## Strings

	@@@ ruby
	"con comillas dobles"
	'con comillas simples'
	"El resultado de 2+2 = #{2+2}"

!SLIDE execute small transition=scrollVert 
# Un poco de Ruby

## Booleans

Ruby tiene una visión simplista de la verdad: *todo lo que no sea `nil` o la constante `false` es `verdadero`* 

	@@@ ruby
	true            # => true
	false           # => false
	nil             # => nil
	1 == 1          # => true 
	1 == true       # => false 
	nil == false    # => false 

## Negacion

	@@@ ruby
	!true           # => false
	!false          # => true
	!nil            # => true
	1 != 2          # => true 
	1 != 1          # => false

!SLIDE execute transition=scrollVert 
# Un poco de Ruby

## Símbolos

Son constantes, que se precedent con el símbolo `:` que ocupan un único espacio de memoria:

	@@@ ruby
	:mi_simbolo.object_id  # => 461608
	"mi_string".object_id  # => 9986260
	"mi_string".object_id  # => 9996160
	:mi_simbolo.object_id  # => 461608

Los símbolos son usados generalmente para acceder a arreglos asociativos, por
ejemplo:

	@@@ ruby
	default[:apache][:ports]

.notes Usar simbolos para mejorar el uso de memoria puede ser un memory leak en algunos casos

!SLIDE execute small transition=scrollVert 
# Un poco de Ruby

## Listas con arreglos

	@@@ ruby
	x = ["a", "b", "c"] # => ["a", "b", "c"]
	x[0]                # => "a" 
	x.first             # => "a" 
	x.last              # => "c"
	x + ["d"]           # => ["a", "b", "c", "d"]
	x                   # => ["a", "b", "c"] 
	x = x + ["d"]       # => ["a", "b", "c", "d"]
	x                   # => ["a", "b", "c", "d"]
	x += ["e"]          # => ["a", "b", "c", "d","e"]
	x                   # => ["a", "b", "c", "d","e"]

!SLIDE execute small transition=scrollVert 
# Un poco de Ruby

## Operando con las listas
	@@@ ruby
	x = [1, 2, 3, 4]
	x.all?                     # => true
	x.all? {|x| x % 2 == 0 }   # => false
	x.any? {|x| x % 2 == 0 }   # => true
	x.detect {|x| x % 2 == 0 } # => 2
	x.each {|x| p x }          # => Imprime cada elem
	x.select {|x| x % 2 }      # => [2, 4]
	x.collect {|x| x*2 }       # => [2, 4, 6, 8]
	x.map                      # Idem collect 
	x.first                    # => 1
	x.last                     # => 4
	x[0]                       # => 1

!SLIDE smbullets transition=scrollVert 
# Un poco de Ruby
## Bloques
* En el ejemplo anterior usabamos bloques con `{...}`
* Un bloque puede tener parámetros `{ |x| ...}`
* Los bloques pueden escribirse en más de una línea usando `do... end`

!SLIDE execute transition=scrollVert 
# Un poco de Ruby
## Bloques en más de una línea

	@@@ ruby
	array = [1, 2, 3, 4]
	
	array.collect! do |n|
		n ** 2
	end

	array


!SLIDE execute smaller transition=scrollVert 
# Un poco de Ruby
## Hashes

Los Hashes son arreglos asociativos y por su estructura semejante a un registro,
son muy utilizados

	@@@ ruby
	grades = { 
	  "Jane Doe" => 10, 
	  "Jim Doe" => 6 
	}
	grades["Jane Doe"]                # => 10

### La sintaxis cambió a partir de la versión 1.9

	@@@ ruby
	options = {                       # => Sintaxis <= 1.8
	  :opt_1 => 1, 
	  :opt_2 => 2
	}
	options = { opt_1: 1, opt_2: 2}   # => Sintaxis > 1.8

> Si un Hash utiliza strings para sus claves, los símbolos no podrán ser utilizados de forma indistinta. Para este tipo de situaciones se utilizan [Mash](https://github.com/mbleigh/mash)

!SLIDE execute smaller transition=scrollVert 
# Un poco de Ruby

## El `if`

En ruby, toda expresión retorna algo. Por tanto:

	@@@ ruby
	a = if true
		3
	end

Se puede escribir en una única línea:

	@@@ ruby
	a = 1
	a = 7 if a < 2

Existen `else` y `elsif`:

	@@@ ruby
	a = 10
	if a < 2
		a = 3
	elsif a == 2
		a = 4
	else
		a = 5
	end

!SLIDE execute transition=scrollVert 
# Un poco de Ruby
## El `unless`

Se utiliza para evitar `if ! <expresion>`

	@@@ ruby
	a = 5
	unless a == 4
		a = 7
	end


!SLIDE execute smaller transition=scrollVert 
# Un poco de Ruby

## Métodos

Los métodos se crean con la palabra `def`

	@@@ ruby
	def do_something_useless( first_argument, second_argument)
		"You gave me #{first_argument} and #{second_argument}"
	end
	do_something_useless( "apple", "banana")

Y se invoca con o sin paréntesis

	@@@ ruby
	do_something_useless( "apple", "banana")
	# => "You gave me apple and banana"
	do_something_useless 1, 2
	# => "You gave me 1 and 2"

> No usar paréntesis puede traer problemas por las reglas de precedencia

!SLIDE smbullets transition=scrollVert 
# Un poco de Ruby
## Clases y Modulos
* No son necesarios en chef porque provee un DSL. Podríamos usar clases si
deseamos, pero el modelo de objetos necesario para Chef no amerita
complicaciones

* Las clases son el concepto conocido

* Los módulos permiten:
  * Definir `namespaces` y sobrecargar clases
  * Permiten implementar `mixins`

!SLIDE smbullets transition=scrollVert 
# Qué son las gemas

* Las gemas son librerías empaquetadas que se instalan desde la red e instalan
  en mi ambiente
* Históricamente se manejaban con el comando `gem`
* Luego `rvm` introdujo el concepto de `gemsets`
* Actualmente las gemas se manejan con [bundler](http://gembundler.com/)

!SLIDE commandline transition=scrollVert 
# Uso de bundler

## Instalando bundler

	$ gem install bundler

!SLIDE commandline transition=scrollVert 
# Uso de bundler
## Usando bundler

Crear un nuevo directorio:

	$ mkdir mi_proyecto

Inicializamos el nuevo directorio

	$ bundle init
	Writing new Gemfile to /xxx/Gemfile

Esto creará un archivo llamado Gemfile, donde podemos agregar dependencias que
utilizaremos en este proyecto, considerando incluso ambientes: *desarrollo*,
*producción*

!SLIDE commandline transition=scrollVert 
# Uso de bundler

Editamos el archivo `Gemfile` y agregamos las gemas necesarios, en este ejemplo
**rainbow**

	@@@ ruby
	# A sample Gemfile
	source "https://rubygems.org"

	# gem "rails"
	gem "rainbow"

Actualizamos el proyecto:

	$ bundle  # o bundle install o bundle update

!SLIDE commandline small transition=scrollVert 
# Uso de bundler
## Usando la Gema
Y ahora podemos crear un script ruby `test.rb`:

	@@@ ruby
	#require 'rainbow'

	puts "this is red".foreground(:red) 
	puts "this on yellow bg".background(:yellow)
	puts "even bright underlined!".underline.bright

*En el ejemplo hay que eliminar el comentario `#` dejando sólo `require 'rainbow'`*

Para correrlo es *IMPORTANTE*:

	$ bundle exec <comando>

En este caso sería:

	$ bundle exec ruby test.rb

`bundle exec` ejecuta el comando usando el ambiente con las gemas mencionadas en el Gemfile

!SLIDE smbullets transition=scrollVert 
# Material de Ruby
  * [Try Ruby](http://tryruby.org/)
  * [Programming Ruby (2nd
    edition)](http://pragprog.com/book/ruby/programming-ruby)
  * [API Ruby](http://www.ruby-doc.org/core-2.0/)
