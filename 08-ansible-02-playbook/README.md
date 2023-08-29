# Домашнее задание к занятию 2 «Работа с Playbook»

## Подготовка к выполнению

1. * Необязательно. Изучите, что такое [ClickHouse](https://www.youtube.com/watch?v=fjTNS2zkeBs) и [Vector](https://www.youtube.com/watch?v=CgEhyffisLY).
2. Создайте свой публичный репозиторий на GitHub с произвольным именем или используйте старый.
3. Скачайте [Playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
4. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Подготовьте свой inventory-файл `prod.yml`.
2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev). Конфигурация vector должна деплоиться через template файл jinja2.
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать дистрибутив нужной версии, выполнить распаковку в выбранную директорию, установить vector.
```
paromov@debian11:~/mnt-homeworks/08-ansible-02-playbook/playbook$ ssh test@51.250.81.26
Last login: Mon Aug 28 22:59:49 2023 from 5.8.51.227
[test@fhmgp65lf74r7rr15vgq ~]$ vector --version
vector 0.31.0 (x86_64-unknown-linux-gnu 0f13b22 2023-07-06 13:52:34.591204470)
[test@fhmgp65lf74r7rr15vgq ~]$ 
```
5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.
```
paromov@debian11:~/mnt-homeworks/08-ansible-02-playbook/playbook$ ansible-lint site.yml 

Passed: 0 failure(s), 0 warning(s) on 1 files. Last profile that met the validation criteria was 'production'.
```
6. Попробуйте запустить playbook на этом окружении с флагом `--check`.
```
PLAY RECAP *******************************************************************************************
clickhouse-01              : ok=8    changed=0    unreachable=0    failed=0    skipped=1    rescued=1    ignored=0   
```
7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.
```
PLAY RECAP *******************************************************************************************
clickhouse-01              : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
```
8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.
```
PLAY RECAP *******************************************************************************************
clickhouse-01              : ok=9    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0
```
9. Подготовьте README.md-файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги. Пример качественной документации ansible playbook по [ссылке](https://github.com/opensearch-project/ansible-playbook).
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.
[ссылка](https://github.com/Romera14/mnt-homeworks/releases/tag/08-ansible-02-playbook)
---

### Как оформить решение задания

Выполненное домашнее задание пришлите в виде ссылки на .md-файл в вашем репозитории.

---
