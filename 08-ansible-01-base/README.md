# Домашнее задание к занятию 1 «Введение в Ansible» - Паромов Роман

## Подготовка к выполнению

1. Установите Ansible версии 2.10 или выше.
2. Создайте свой публичный репозиторий на GitHub с произвольным именем.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть

1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте значение, которое имеет факт `some_fact` для указанного хоста при выполнении playbook.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
ok: [localhost]

TASK [Print OS] **************************************************************************************
ok: [localhost] => {
    "msg": "Debian"
}

TASK [Print fact] ************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP *******************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
2. Найдите файл с переменными (group_vars), в котором задаётся найденное в первом пункте значение, и поменяйте его на `all default fact`.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/test.yml 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
ok: [localhost]

TASK [Print OS] **************************************************************************************
ok: [localhost] => {
    "msg": "Debian"
}

TASK [Print fact] ************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP *******************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.
4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "CentOS"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "deb"
}
ok: [centos7] => {
    "msg": "el"
}

PLAY RECAP *******************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились значения: для `deb` — `deb default fact`, для `el` — `el default fact`.

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "CentOS"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "el default fact"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-vault encrypt group_vars/deb/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-vault encrypt group_vars/el/examp.yml 
New Vault password: 
Confirm New Vault password: 
Encryption successful
```
8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "CentOS"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "el default fact"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```
9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-doc -t connection -l
[WARNING]: Collection vyos.vyos does not support Ansible version 2.13.6
[WARNING]: Collection ibm.qradar does not support Ansible version 2.13.6
[WARNING]: Collection junipernetworks.junos does not support Ansible version 2.13.6
[WARNING]: Collection ansible.posix does not support Ansible version 2.13.6
[WARNING]: Collection ansible.netcommon does not support Ansible version 2.13.6
[WARNING]: Collection frr.frr does not support Ansible version 2.13.6
[WARNING]: Collection cisco.asa does not support Ansible version 2.13.6
[WARNING]: Collection cisco.nxos does not support Ansible version 2.13.6
[WARNING]: Collection cisco.iosxr does not support Ansible version 2.13.6
[WARNING]: Collection openvswitch.openvswitch does not support Ansible version 2.13.6
[WARNING]: Collection splunk.es does not support Ansible version 2.13.6
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                  
ansible.netcommon.libssh       (Tech preview) Run tasks using libssh for ssh connection          
ansible.netcommon.napalm       Provides persistent connection using NAPALM                       
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol       
ansible.netcommon.network_cli  Use network_cli to run command on network appliances              
ansible.netcommon.persistent   Use a persistent unix socket for connection                       
community.aws.aws_ssm          execute via AWS Systems Manager                                   
community.docker.docker        Run tasks in docker containers                                    
community.docker.docker_api    Run tasks in docker containers                                    
community.general.chroot       Interact with local chroot                                        
community.general.docker       Run tasks in docker containers                                    
community.general.funcd        Use funcd to connect to target                                    
community.general.iocage       Run tasks in iocage jails                                         
community.general.jail         Run tasks in jails                                                
community.general.lxc          Run tasks in lxc containers via lxc python library                
community.general.lxd          Run tasks in lxc containers via lxc CLI                           
community.general.oc           Execute tasks in pods running on OpenShift                        
community.general.qubes        Interact with an existing QubesOS AppVM                           
community.general.saltstack    Allow ansible to piggyback on salt minions                        
community.general.zone         Run tasks in a zone instance                                      
community.kubernetes.kubectl   Execute tasks in pods running on Kubernetes                       
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                           
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                        
community.okd.oc               Execute tasks in pods running on OpenShift                        
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                        
containers.podman.buildah      Interact with an existing buildah container                       
containers.podman.podman       Interact with an existing podman container                        
local                          execute on controller                                             
paramiko_ssh                   Run tasks via python ssh (paramiko)                               
psrp                           Run tasks over Microsoft PowerShell Remoting Protocol             
ssh                            connect via SSH client binary                                     
winrm                          Run tasks over Microsoft's WinRM 
```
Выберем ```local```

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.
11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь, что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
```
paromov@debian11:~/mnt-homeworks/08-ansible-01-base/playbook$ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-pass
Vault password: 

PLAY [Print os facts] ********************************************************************************

TASK [Gathering Facts] *******************************************************************************
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [localhost]
ok: [ubuntu]
ok: [centos7]

TASK [Print OS] **************************************************************************************
ok: [localhost] => {
    "msg": "Debian"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "CentOS"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] ************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [centos7] => {
    "msg": "el default fact"
}
[WARNING]: The "docker" connection plugin has an improperly configured remote target value, forcing
"inventory_hostname" templated value instead of the string
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP *******************************************************************************************
centos7                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0
```
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.
3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.
4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот вариант](https://hub.docker.com/r/pycontribs/fedora).
5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.
6. Все изменения должны быть зафиксированы и отправлены в ваш личный репозиторий.

---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
