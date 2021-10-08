#!/bin/bash

# Сценарий должен создать архив (*.tar.gz) всех файлов в заданном каталоге,
# которые изменялись в течение последних 24 часов. Подсказка:
# воспользуйтесь утилитой find.

PATH_CATALOG="$1"
NAME_ARHIVE='arh_tar.tar'
COMMAND_FIND=$(find ${PATH_CATALOG} -cmin +0 -cmin -1440)
COMMAND_TAR_CREATE="tar -cvf ${NAME_ARHIVE}"
COMMAND_TAR_APPEND="tar -rvf ${NAME_ARHIVE}"
COMMAND_COMPRESS_ARHIVE="gzip -9"

def_compress_arhive ()
{
  if test -f $NAME_ARHIVE; then
    $COMMAND_COMPRESS_ARHIVE $NAME_ARHIVE
  fi
}

def_file_arhv_tar ()
{
  if test -f $NAME_ARHIVE; then
    $COMMAND_TAR_APPEND ${file}
    echo "Файл: ${file} --- добавлен в архив: ${NAME_ARHIVE}!"
  else
    $COMMAND_TAR_CREATE ${file}
    echo "Файл: ${file} --- добавлен в архив: ${NAME_ARHIVE}!"
  fi
}

def_check_file ()
{
  if test -f $file; then
    echo
    echo "${file} - это файл!"
    echo
    def_file_arhv_tar $file
  fi
}

if test -z $PATH_CATALOG; then
  echo
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до каталога! В формате:"
  echo "./6.sh /path/path/folder/"
  echo
else
  for file in $COMMAND_FIND; do
    def_check_file $file
  done
  def_compress_arhive
fi

exit 0
