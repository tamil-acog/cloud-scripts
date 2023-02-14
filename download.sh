download_from_box()
{
  storage_id=$1
  directory=$2/
  project_id=$3
  main_dir=$4
  file="${main_dir}/atk-funcs.sh"
  source $file

  rsync -avzP storagebox:/home/${storage_id}/${project_id}/ ${directory}
  e_success "The results have been downloaded the the local storage"

}

download_from_box $1 $2 $3 $4