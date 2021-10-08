#!/bin/bash

# Содержимое домашнего каталога
# Выполните рекурсивный обход домашнего каталога и сохраните информацию в файл.
# Сожмите файл.
# Попросите пользователя вставить дискету и нажать клавишу ENTER.
# Запишите сжатый файл на дискету.

DEVICE_USB="$1"
LOG_FILE=1_log_file.log
ARHIVE_FILE=1_log_file.tar
COMPRESSION_FILE=1_log_file.tar.bz2
DIRRECTORY_RECURSIVE=/home/hulumulu/
COMMAND_DELETE="rm ${LOG_FILE}"
COMMAND_COMPRESSION="bzip2 -9 ${ARHIVE_FILE}"
COMMAND_ARHIVE="tar -cvf ${ARHIVE_FILE} ${LOG_FILE}"
COMMAND_COPY_FILE_IN_USB_FLASH="cp ${COMPRESSION_FILE} ${DEVICE_USB}"

def_file_manipulation ()
{
  echo
  echo "Делаю рекурсивный обход директории: ${DIRRECTORY_RECURSIVE}"
  echo "И записываю в файл: ${LOG_FILE}"
  ls -lR ${DIRRECTORY_RECURSIVE}>>${LOG_FILE}
  echo
  echo "Проверяю наличие файла: ${LOG_FILE}"
  if test -e "$LOG_FILE"
  then
    echo "Файл: ${LOG_FILE} существует"
    echo
    echo "Архивирую файл: ${LOG_FILE} в файл: ${ARHIVE_FILE}"
    $COMMAND_ARHIVE
    echo "Проверяю наличие файла: ${ARHIVE_FILE}"
    if test -e "$ARHIVE_FILE"
    then
      echo "Файл: ${ARHIVE_FILE} существует"
      echo "Сжимаю файл: ${ARHIVE_FILE}"
      $COMMAND_COMPRESSION
    else
      echo "Файл: ${ARHIVE_FILE} не существует"
    fi
  else
    echo "Файл: ${LOG_FILE} не существует"
  fi
  echo
  if test -e "$COMPRESSION_FILE"
  then
    echo "Удаляю файл: ${LOG_FILE}"
    $COMMAND_DELETE
  else
    echo "Файл: ${COMPRESSION_FILE} не существует"
  fi
}

def_copy_file_in_flash ()
{
  if test -e "$COMPRESSION_FILE"
  then
    echo
    echo "Копирую файл: ${COMPRESSION_FILE} в: ${DEVICE_USB}"
    $COMMAND_COPY_FILE_IN_USB_FLASH
  else
    echo "NO FILE: ${COMPRESSION_FILE}"
  fi
}

if test -z "$DEVICE_USB"
then
  echo "Аргументы командной строки отсутствуют."
  echo "Введите путь до usb-флешки! В формате:"
  echo "./4.sh /media/name_user/USB_FLASH/"
else
  def_file_manipulation
  def_copy_file_in_flash
fi

exit 0
