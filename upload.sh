sync_to_box()
{
  storage_id=$1
  directory=$2/
  main_dir=$3
  file="${main_dir}/atk-funcs.sh"
  source $file
  if [ -d $2 ]; then
    if ssh storagebox ls /home | grep -q -i ${storage_id} ; then
      e_success "Your storage_id exists"
      e_arrow "Uploading the files to the storagebox"
      a=$(ssh storagebox ls /home/${storage_id} | tail -1 | tail -c 2)
      file_num=$(( ${a} + 1))
      input=$(echo "project_$file_num")
      rsync -avz ${directory} storagebox:/home/${storage_id}/${input} 2>&1 >/dev/null
      e_arrow "Your local directory ${2} has been uploaded to the storagebox"
      e_success $(e_bold "Your project_id is \"${input}\"")
    else
      e_error "You storage_id ${1} doesn't exist.Please contact the admin to create a user account in Storage box"
    fi
  else
    e_error "${2}: No such file or directory"
  fi
}

sync_to_box $1 $2 $3