# libreoffice
Libreoffice Automation Tests


Set up of tools for libreoffice test automation

+ Required packages:

	- python2.7
	- python-behave-1.2 (link: http://pythonhosted.org/behave/install.html)
		a. install python-pip (yum: yum -y install python-pip)
		b. pip install behave
	- libreoffice (including writer, impress, draw, calc, base) 
	- good to have: "yum install dogtail"

+ Set up project:

	1. Clone git repo of project tests (link: // TO DO:- add link)
	2. Add submodule behave_common_steps 
		a. run (in root folder of project): git submodule init; git submodule add ./behave_common_steps ; git submodule update
	3. Repository should be ready
		a. if needed change current git branch to your personal git branch (git checkout "name_of_branch")
		b. run command in root folder of project git submodule status and check if there is  behave_common_steps


+ How to run test:

	- From command line run command: behave -t "name_of_test"
	- name_of_test is defined in *.feature file after the @ sign
	- example: behave -t start_soffice_via_command
