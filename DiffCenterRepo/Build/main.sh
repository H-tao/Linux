export RUN_TYPE=$1
export work_path=$2
export service_name=$3
export branchName=$4


export work_diff_path="${work_path}/DiffCenterRepo"
export work_fst_build_path="${work_diff_path}/Build"
export ACTIVE_LOG_FNAME="${work_path}/diffcenterrepo.log"
export common_path="${work_fst_build_path}/src/common"
export work_fst_solution_path="${work_diff_path}/Solution"
export PROJECT_ROOT="${work_path}/${service_name}"
export branch_extra_name="${branchName}"
export common_func_file="${common_path}/common_func.sh"
yaml_file="${work_fst_solution_path}/${service_name}/build.yaml"


# 导入公共函数
source "${common_path}/common_func.sh"


#patch的参数，用来处理patch开源包
export patch_source="${work_path}/${service_name}_patch_source"     # 开源中心仓的源代码
export patch_build="${work_path}/${service_name}_patch_build"       # 开源中心仓打patch后的代码
export patch_code="${work_path}/${service_name}_patch"              # patch
__write_log "$(basename $BASH_SOURCE):$LINENO" "system para: patch_source=${patch_source}"
__write_log "$(basename $BASH_SOURCE):$LINENO" "system para: patch_build=${patch_build}"
__write_log "$(basename $BASH_SOURCE):$LINENO" "system para: patch_code=${patch_code}"


# 下载团队开源仓，下载到 [WORKSPACE/服务名] 目录下
__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=download_git_url_tmp=$(python ${common_path}/yaml_reader.py --get giturl --yamlfile ${yaml_file})"
download_git_url_tmp=$(python ${common_path}/yaml_reader.py --get giturl --yamlfile ${yaml_file})
download_git_local_dirctoryname_tmp="${service_name}"
src_path_service="${download_git_url_tmp}"
if [[ "${service_name}" = "gophercloud" ]]; then
  repo_branch="opensource_patch"
else
  repo_branch=${branchName}
fi

__download_git ${work_path} ${download_git_url_tmp} ${download_git_local_dirctoryname_tmp} ${src_path_service} ${repo_branch}


# 下载Patch仓，下载到 [WORKSPACE/服务名_patch] 目录下
__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=download_git_url_tmp=$(python ${common_path}/yaml_reader.py --get patch_git_url --yamlfile ${yaml_file})"
export git_url_patch=$(python ${common_path}/yaml_reader.py --get patch_git_url --yamlfile ${yaml_file})

__configure_patch_branch
export git_patch_path="${work_path}/${service_name}_patch"
__git_download_extra


# 下载公司开源中心仓代码，下载到 [WORKSPACE/服务名_patch_source] 目录下
__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=download_git_url_tmp=$(python ${common_path}/yaml_reader.py --get central_repo_url --yamlfile ${yaml_file})"
export central_repo_url=$(python ${common_path}/yaml_reader.py --get central_repo_url --yamlfile ${yaml_file})
export central_patch_path="${work_path}/${service_name}_patch_source"
__central_repo_download


# 打patch入公司开源代码，打入到 [WORKSPACE/服务名_patch_build] 目录下，这个函数会调用apple_patch
export patch_build="${work_path}/${service_name}_patch_build"
__preprocess_patch_pre


# 打patch入团队开源仓代码，打入到 [WORKSPACE/服务名_build] 目录下
export project_patch_path="${work_path}/${service_name}_build"
__process_service_patch
# 团队仓已经集成了patch包？？？


# 打包
export post_dir="${postPath}"
export pre_dir="${prePath}"
__process_bep_files


