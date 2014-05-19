dzzwithdocker
=============

在docker中的部署DzzOffice

Usage
------------------------------

clone或者download 本项目到本地，然后进入（解压）目录中，运行

	docker build -t dzz .
  
创建了dzz镜像(image)之后，就可以运行下面的命令来运行 **DzzOffice**

	docker run -d -p 80:80 -p 22:22 dzz
  
Information
-----------

运行docker container后，可以通过 http://ip/install 来完成 **DzzOffice** 的安装，Mysql数据的初始账户: admin/admin

当然，你还可以使用SSH登录到docker container中，就如同管理一台ubuntu机器一样管理这个container


系统包含如下环境

  ==================================
  
  Apache2, Mysql, php5, DzzOffice, SSH
  
  ==================================


更多关于DzzOffice，请访问 <http://www.dzzoffice.com/> 
