!SLIDE subsection center transition=scrollVert
# Attributes en Chef

!SLIDE bullets small transition=scrollVert

# Attributes

* Los *attributes* son un detalle específico de un nodo. Chef utiliza los attributes para entender:
  * El estado actual de un nodo
  * Cuál era el estado del nodo al finalizar la anterior corrida de Chef
  * Cuál debería de ser el estado del nodo al finalizar la corrida de Chef
* Los attributes son definidos por:
  * El estado mismo del nodo
  * Cookbooks: mediante archivos en el directorio `attributes/` y/o recipes
  * Roles
  * Environments

!SLIDE bullets small transition=scrollVert

# Attributes

* Durante cada corrida de Chef, `chef-client` arma la lista de attributes
  usando:
  * Datos recolectados de *ohai*
  * El objeto `node` guardado en Chef Server al finalizar la corrida previa
    de Chef
  * La reconstrucción del objeto `node` para la actual corrida de Chef, luego de
    actualizar cookbooks (mediante los archivos en el directorio `attributes/`
y/o recipes), roles, environments, y actualizaciones de cualquier estado en el
mismo `node` (por ejemplo ohai)

Una vez reconstruído el objeto `node`, todos los attributes son comparados y
actualizados siguiendo las reglas de precedencia.

Al finalizar la corrida de Chef, el objeto `node` que define el estado actual
del mismo es subido al Chef Server con la finalidad de indexarlo y así permitir
búsquedas.

!SLIDE smbullets small transition=scrollVert

# Attribute Types

* `default`: estos atributos son resetados al iniciar cada corrida de Chef y
  tienen la menor precedencia. Un cookbook debe crearse utilizando tantos atributos por
defecto como sea posible, sin dejar atributos sin valor.
* `force_default`: estos atributos son usados para *asegurar* que un atributo definido en un
  cookbook (mediante archivos en el directorio `attributes` y/o recipes) toma
precedencia sobre el atributo `default` definido por un *role* o *environment*
* `normal`: estos atributos son seteos que persisten en el sistema destino y
  nunca son reseteados por una corrida de Chef. Los atributos `normal` tienen
mayor precedencia que los `default`

!SLIDE smbullets small transition=scrollVert

# Attribute Types
* `override`: estos atributos son automáticamente reseteados al inicio de cada
  corrida de Chef, y tiene mayor precedencia que los atributos `default`,
`force_default` y `normal`. Son *mayormente* utilizados en recipes, pero pueden
especificarse en archivos de `attributes`, *roles* o *environments*. Un cookbook
debe utilizar este tipo de atributos *sólo cuando sea necesario*.
* `force_override`: estos atributos son usados para *asegurar* que un atributo
  definido en un cookbook (mediante archivos en el directorio `attributes` y/o recipes) toma
precedencia sobre el atributo `override` definido por un *role* o *environment*
* `automatic`: estos atributos contienen datos identificados por *Ohai* al
  inicio de cada corrida de Chef. Un atributo `automatic` no puede modificarse y
*siempre* tiene la precedencia más alta


!SLIDE transition=scrollVert

# Attribute Types

Al inicio de cada corrida de Chef, se *resetean* todos los atributos `default`, `override` y
`automatic`. 

Chef reconstruirá los atributos recolectando información de *Ohai*
al inicio de cada corrida de Chef, y atributos definidos en el cookbook, roles
y/o environments.

Los atributos `normal` *nunca son resetados*

Luego todos los atributos se mezclan y aplican al node de acuerdo a la
precedencia de atributos.

Al finalizar la corrida de Chef, todos los atributos `default`, `override` y
`automatic` desaparecen, dejando sólo la colección de atributos `normal` que
persistirán hasta la próxima corrida de Chef.

!SLIDE transition=scrollVert

# Attribute Types

Al inicio de cada corrida de Chef, se *resetean* todos los atributos `default`, `override` y
`automatic`. 

Chef reconstruirá los atributos recolectando información de *Ohai*
al inicio de cada corrida de Chef, y atributos definidos en el cookbook, roles
y/o environments.

