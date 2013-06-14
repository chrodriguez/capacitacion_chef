!SLIDE subsection center transition=scrollVert
![AWS](aws.png)
# Amazon EC2

!SLIDE smbullets transition=scrollVert
# Amazon EC2
* Amazon provee un servicio de [PaaS](http://en.wikipedia.org/wiki/Platform_as_a_service)
* Se maneja con templates llamados [AMI](https://aws.amazon.com/amis/)
* Tiene un costo, pero puede usarse sin costo durante 1 año, una cantidad de
  horas prefijada
* Chef se integra con cualquier máquina, no sería un problema Amazon EC2
* Vagrant a partir de la versión 1.2.x soporta como provider Amazon EC2

!SLIDE smbullets small transition=scrollVert
# Algunos cookbooks con soporte en Amazon EC2
* En los siguientes cookbooks hay un Vagrantfile-aws que debe linkearse y usarse
  con la clave propia de AWS EC2
  * [Cookbook de choique](https://github.com/Desarrollo-CeSPI/choique_cookbook)
  * [Cookbook de Kimkelen](https://github.com/Desarrollo-CeSPI/kimkelen_cookbook)
  * [Cookbook de Meran](https://github.com/Desarrollo-CeSPI/meran_cookbook)
* El problema es que las máquinas de Amazon no tienen *chef* por lo que hay un
  plugin de Vagrant que soluciona este problema: [Vagrant Omnibus](https://github.com/schisamo/vagrant-omnibus)
  * `$ vagrant plugin install vagrant-omnibus`

## ¿Como probarlo?

`$ vagrant up --provider=aws`
