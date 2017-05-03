:: This script downloads the project to FTP, downloads configuration files and init project and migrates to the server
::_______________________________
::%site% - URL repository site
::%loginFTP% - Login FTP server
::%passwordFTP% - password FTP server
::%configSite% - URL repository configuration for site
::%urlFTP% - URL FTP server
::________________________________________
set site=https://github.com/lolk12/MetaliaDev.git
set configSite=https://github.com/lolk12/MetaliaDevConfig.git
set loginFTP=w_alextest-comstoc_0bb5e620
set passwordFTP=e7426637234
set urlFTP=ftp.alextest-comstoc.1gb.ru

rmdir MetaliaDevConfig
ssh -p 2222 %loginFTP%@%urlFTP% 'rm -rf http/*' 
git clone %site%
git clone %configSite%
ncftpput -u %loginFTP% -p %passwordFTP% -R %urlFTP% /http/ MetaliaDev/*
ssh -p 2222 %loginFTP%@%urlFTP% 'cd http/_protected' 'php init --env=Development --overwrite=All' 
ncftpput -u %loginFTP% -p %passwordFTP% -R %urlFTP% /http/ MetaliaDevConfig/*
ssh -p 2222 %loginFTP%@%urlFTP% 'cd http/_protected' 'php yii migrate'
pause
