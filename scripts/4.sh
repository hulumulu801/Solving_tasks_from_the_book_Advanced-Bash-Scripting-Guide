#!/bin/bash

# Для каждого файла, из заданного списка, сценарий должен определить тип архиватора,
# которым был создан тот или иной файл (с помощью утилиты file). Затем сценарий должен
# выполнить соответствующую команду разархивации (gunzip, bunzip2, unzip, uncompress или
# что-то иное). Если файл не является архивом, то сценарий должен оповестить пользователя об
# этом и ничего не делать с этим файлом.

FOLDER_PATH="$1"
COMMAND_FILE="file ${FOLDER_PATH}*"

def_func_bzip()
{
  echo
  echo "Разархивировать файл ${file} ?"
  echo "Y/N"
  read bzip_name
  if [ "${bzip_name^^}" == "Y" ]; then
    bzip2 -d ${file}
    echo "Файл: ${file} разархивирован!"
  fi
}

def_func_gzip()
{
  echo
  echo "Разархивировать файл ${file} ?"
  echo "Y/N"
  read gzip_name
  if [ "${gzip_name^^}" == "Y" ]; then
    gzip -d ${file}
    echo "Файл ${file} разархивирован!"
  fi
}

def_func_tar()
{
  echo
  echo "Разархивировать файл ${file} ?"
  echo "Y/N"
  read tar_name
  if [ "${tar_name^^}" == "Y" ]; then
    tar -C ${FOLDER_PATH} -xvf ${file}
    echo
    echo "Файл ${file} разархивирован!"
  fi
}

def_func_file_no_arhive()
{
  echo
  echo "Файл: ${file} не является архивом!"
}

if test -z $FOLDER_PATH; then
  echo
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до папки с файлами! В формате:"
  echo "./4.sh /path/path/folder/"
else
  for file in $COMMAND_FILE; do
    if (file $file | grep 'bz2'); then
      def_func_bzip $file
    elif (file $file | grep 'gz'); then
      def_func_gzip $file
    elif (file $file | grep 'tar'); then
      def_func_tar $file $FOLDER_PATH
    else
      def_func_file_no_arhive $file
    fi
  done
fi

exit 0
