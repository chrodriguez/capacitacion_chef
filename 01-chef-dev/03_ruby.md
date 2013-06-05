!SLIDE subsection center transition=scrollVert 
[![Ruby](ruby.png)](http://www.ruby-lang.org/es/)
# Fundamentos de ruby

!SLIDE smbullets small transition=scrollVert 
#Fundamentos de ruby

* De origen Japonés
* Lenguaje simple de leer pero potente
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

!SLIDE bullets transition=scrollVert 
# Un poco de Ruby

* Comentario

	@@@ ruby
	# Este es un comentario

* Asignación
* Artimética básica
* Strings
  * Ruby dentro de strings
* Boolenos
* Negacion
* Listas con arreglos
* Operando con las listas
* Hashes
* Mashes
* Expresiones regulares
* Condicionales
* Métodos
* *Clases*
  * No son necesarias en chef


