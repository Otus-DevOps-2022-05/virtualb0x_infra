# virtualb0x_infra
virtualb0x Infra repository

# Выполнено ДЗ № 3

 - [X] Основное ДЗ
 - [X] Задание со *

## В процессе сделано:
 - Испытана масса "приятных" ощущений по поводу того, что монга не ставится скриптом
 - В связи с пунктом первым найдены огородные пути установки монги
 - Развенуты 2 ВМ в облаке яндекса
 - Установлены те пакеты, что предлагались к установке в setup.sh скрипте
 - Проверены подклбючения напрячмую, через -J
 - Настроен oVPN сервер, проверено подключение к нему
 - Настроено подключение без ошибки о сертификате

## Как запустить проект:
 - Никак :)

## Как проверить работоспособность:
### Cпособ подключения к someinternalhost в одну команду


bastion_IP=51.250.85.222

someinternalhost_IP=10.128.0.12


ssh -i ~/.ssh/appuser -J appuser@51.250.85.222 appuser@10.128.0.12

или

ssh -i ~/.ssh/appuser -J appuser@$bastion_IP appuser@$someinternalhost_IP

    где 51.250.85.222 - внешний ip адрес машины bastion;

    10.128.0.12 - внутренний ip адрес  someinternalhost;

    -J destination -  Connect to the target host by first making a ssh connection to the jump host described by destination and then establishing a TCP forwarding to the ultimate destination from there.  Multiple
    jump hops may be specified separated by comma characters.  This is a shortcut to specify a ProxyJump configuration directive.  Note that configuration directives supplied on the command-line
    generally apply to the destination host and not any specified jump hosts.  Use ~/.ssh/config to specify configuration for jump hosts.

  ### Предложить вариант решения для подключения из консоли при помощи
  команды вида ssh someinternalhost из локальной консоли рабочего
  устройства

  ```
  touch  ~/.ssh/config

  vi ~/.ssh/config                                                                                                                         
  Host bastion
    HostName 51.250.85.222
    User appuser
    Port 22
    ForwardAgent yes
    AddKeysToAgent yes
    IdentityFile ~/.ssh/appuser

  Host someinternalhost
    User appuser
    Hostname 10.128.0.12
    Port 22
    ProxyJump bastion
    ForwardAgent Yes
  ```

Подключение:
```
eval `ssh-agent -s`

ssh someinternalhost                                                                                                                                             ✔
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-117-generic x86_64)

* Documentation:  https://help.ubuntu.com
* Management:     https://landscape.canonical.com
* Support:        https://ubuntu.com/advantage
Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings

Last login: Fri Jun 17 11:48:04 2022 from 10.128.0.12

```

 ### Правка самоподписанного сертификата для Pritunl:

аходим на нашу панель управления по адресу: https://<bastion_IP>.sslip.io

 Логинимся, заходим в настройки, в LE Domain вводим имя хоста: 51.250.85.222.sslip.io

 Сохраняемся

 Идём по ssh на bastion. Рестартуем сервис pritunl.
 ```

 appuser@bastion:~$ sudo systemctl restart pritunl.service
 appuser@bastion:~$ sudo systemctl status  pritunl.service
 ● pritunl.service - Pritunl Daemon
 Loaded: loaded (/etc/systemd/system/pritunl.service; enabled; vendor preset: enabled)
 Active: active (running) since Sun 2022-06-19 15:54:06 UTC; 21s ago
 Main PID: 27402 (pritunl)
 Tasks: 95 (limit: 1102)
 Memory: 287.6M
 CGroup: /system.slice/pritunl.service
 ├─27402 /usr/lib/pritunl/bin/python /usr/lib/pritunl/bin/pritunl start
 └─27525 pritunl-web

 Jun 19 15:54:06 bastion systemd[1]: Started Pritunl Daemon.
 Jun 19 15:54:23 bastion pritunl[27525]: 2022/06/19 15:54:23 http: TLS handshake error from 46.147.247.89:51582: remote error: tls: unknown certificate
 Jun 19 15:54:24 bastion pritunl[27525]: 2022/06/19 15:54:24 http: TLS handshake error from 46.147.247.89:51600: remote error: tls: unknown certificate
 Jun 19 15:54:26 bastion pritunl[27525]: 2022/06/19 15:54:26 http: TLS handshake error from 46.147.247.89:51614: remote error: tls: unknown certificate

 ```

 Возвращаемся в браузер. Проверяем.

## PR checklist
 - [x] Выставил label с номером домашнего задания
 - [x] Выставил label с темой домашнего задания



 # Выполнено ДЗ № 4

  - [X] Основное ДЗ
  - [X] Задание со *

 ## В процессе сделано:
 - Всё ещё подгорает от того, что пихаются репы монги, до которой нет доступа

 - Установлен YC CLI
 ```
 [loa@loa-work ~]$ which yc
/home/loa/yandex-cloud/bin/yc
 ```
 - Проверен YC CLI
```
[loa@loa-work ~]$ yc config profile list
test ACTIVE
[loa@loa-work ~]$  yc config list
token: *********-rvKJT4IbqqQ
cloud-id: b1gcaif0v100d3f51n13
folder-id: b1g1kvm2lpcc289v9i5k
compute-default-zone: ru-central1-a
```

- Создан инстанс

```
[loa@loa-work ~]$ yc compute instance list
+----------------------+------------+---------------+---------+--------------+-------------+
|          ID          |    NAME    |    ZONE ID    | STATUS  | EXTERNAL IP  | INTERNAL IP |
+----------------------+------------+---------------+---------+--------------+-------------+
| fhmfma9i7qt19bg1othu | reddit-app | ru-central1-a | RUNNING | 51.250.64.52 | 10.128.0.29 |
+----------------------+------------+---------------+---------+--------------+-------------+
```
- Установлен Ruby и Bundler
```
yc-user@reddit-app:~$ ruby -v
ruby 2.3.1p112 (2016-04-26) [x86_64-linux-gnu]
yc-user@reddit-app:~$ bundler -v
Bundler version 1.11.2
```
- Установлена и проверена монга
```
c-user@reddit-app:~$ systemctl status mongodb
● mongodb.service - An object/document-oriented database
Loaded: loaded (/lib/systemd/system/mongodb.service; enabled; vendor preset: enabled)
Active: active (running) since Wed 2022-06-22 18:13:26 UTC; 32min ago
Docs: man:mongod(1)
Main PID: 2965 (mongod)
CGroup: /system.slice/mongodb.service
└─2965 /usr/bin/mongod --config /etc/mongodb.conf
yc-user@reddit-app:~$
```
- Задеплоено приложение

 ## Как запустить проект:
  - Никак :)

 ## Как проверить работоспособность:

 ```
 testapp_IP = 51.250.5.135
 
 testapp_port = 9292
 ```
 
 http://51.250.5.135:9292/

