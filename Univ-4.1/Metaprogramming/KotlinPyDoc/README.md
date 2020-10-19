# Метапрограмування

### Лабораторна робота № 1: Проектування та розробка генераторiв програмної документацiї

Варіант 8: Kotlin

### Завдання

Використовуючи мову програмування Python 3, розробити консольну утилiту генерацiї
документацiї програмних кодiв для певної мови програмування та документацiю для її
використання.

### Використання

Команда `KotlinPyDoc.py -h` відкриє довідку:

```
usage: KotlinPyDoc [-h] [-r] [--output OUTPUT] path

Generate documentation for Kotlin project.

positional arguments:
  path             Path to the folder or Kotlin file

optional arguments:
  -h, --help       show this help message and exit
  -r, --recursive  enable recursive mode(folders only)
  --output OUTPUT  output path
``` 

Якщо `path` вказує на файл - буде згенеровано документацію для файлу

Якщо `path` вказує на папку - буде згенеровано документацію для папки

Якщо `path` вказує на папку і передано ключ `-r` або `--recursive` - буде згенеровано документацію для папки та всіх підпапок

За наявності `--output OUTPUT` результат буде згенеровано по шляху `OUTPUT` 