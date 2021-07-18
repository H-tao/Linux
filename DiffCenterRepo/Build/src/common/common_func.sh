#!/bin/bash
# Copyright Huawei Technologies Co., Ltd. 2019-2020. All rights reserved.
###################################################################################
#
# common_func.sh
# -- 全局通用函数
#
###################################################################################


###################################################################################
# 函数名称： __write_log "$(basename $BASH_SOURCE), $LINENO"
# 功能描述： 全局打印日志函数，一条日志输出到屏幕，一条日志输出到指定的日志文件中
#           支持日志设置日志级别和不同的级别设置不同的提示颜色&闪烁效果，当前支持ERROR:红色  WARN：黄色
#           每条日志的前面加上打印时间、调用处的文件名和行号，以及日志级别，格式如：[2019-07-31 15:17:46][build_microservice_post.sh, 16][INFO] 打印内容
# 输入参数： $1，$(basename $BASH_SOURCE)，为调用处的文件名和行号||日志级别LEVEL支持DEBUG INFO WARN ERROR
#            $2，设置了LEVEL是$(basename $BASH_SOURCE)，为调用处的文件名和行号，否则是要打印的内容
#            $3，设置了LEVEL是要打印的内容，否则不传递该参数
#            调用方式如：
#            __write_log "$(basename $BASH_SOURCE), $LINENO" "Begining: enter build_microservice.sh ${FILENAME_LINENO}"
#            __write_log ${LEVEL} "$(basename $BASH_SOURCE), $LINENO" "Begining: enter build_microservice.sh ${FILENAME_LINENO}"
# 输出参数： 无
# 返回  值： 无
###################################################################################
function __write_log() {
    level=$1

    case ${level} in
    "DEBUG")
        printf "%s%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "[DEBUG]" "$3"
        printf "%s%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "[DEBUG]" "$3" >> $ACTIVE_LOG_FNAME 2>&1
    ;;
    "INFO")
        printf "%s%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "[INFO]" "$3"
        printf "%s%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "[INFO]" "$3" >> $ACTIVE_LOG_FNAME 2>&1
    ;;
    "WARN")
        printf "%s%s\033[4m\033[5;33m[WARN]\033[0m %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "$3"
        printf "%s%s\033[4m\033[5;33m[WARN]\033[0m %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "$3" >> $ACTIVE_LOG_FNAME 2>&1
    ;;
    "ERROR")
        printf "%s%s\033[4m\033[5;31m[ERROR]\033[0m %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "$3"
        printf "%s%s\033[4m\033[5;31m[ERROR]\033[0m %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$2]" "$3" >> $ACTIVE_LOG_FNAME 2>&1
    ;;
    *)
        printf "%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$1]" "$2"
        printf "%s%s %s \n" "[$(LD_PRELOAD=  date -d today +"%m-%d %H:%M:%S")]" "[$1]" "$2" >> $ACTIVE_LOG_FNAME 2>&1
    ;;
    esac

 }



###################################################################################
# 函数名称： __download_git
# 功能描述： 下载git仓库的内容
# 输入参数： $1：clone_work_path_tmp                     #git clone的工作路径
#            $2：download_git_url_tmp                    #要下载的git的url
#            $3：download_git_local_dirctoryname_tmp     #git clone到本地的指定目录名称
#            $4：checkout_work_path_tmp                  #git checkout的工作路径
#            $5：git_branch_name_tmp                     #git仓库的branh名称
# 输出参数：
# 返回  值： 无
###################################################################################
function __download_git() {
    __write_log "$(basename $BASH_SOURCE), $LINENO" " "
    __write_log "$(basename $BASH_SOURCE), $LINENO" "Enter function: __download_git()"

    clone_work_path_tmp=$1
    download_git_url_tmp=$2
    download_git_local_dirctoryname_tmp=$3
    checkout_work_path_tmp=$4
    git_branch_name_tmp=$5

    __write_log "$(basename $BASH_SOURCE), $LINENO" "clone_work_path_tmp=${clone_work_path_tmp}"
    __write_log "$(basename $BASH_SOURCE), $LINENO" "download_git_url_tmp=${download_git_url_tmp}"
    __write_log "$(basename $BASH_SOURCE), $LINENO" "download_git_local_dirctoryname_tmp=${download_git_local_dirctoryname_tmp}"
    __write_log "$(basename $BASH_SOURCE), $LINENO" "checkout_work_path_tmp=${checkout_work_path_tmp}"
    __write_log "$(basename $BASH_SOURCE), $LINENO" "git_branch_name_tmp=${git_branch_name_tmp}"


    __write_log "$(basename $BASH_SOURCE), $LINENO" "begin to git pull git"
    __write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=cd ${clone_work_path_tmp}"
    cd ${clone_work_path_tmp}
    #修改git clone方式
    mkdir -p ${download_git_local_dirctoryname_tmp}
    cd ${download_git_local_dirctoryname_tmp}
    git init
    git remote add origin ${download_git_url_tmp}
    options="${git_branch_name_tmp}"
    checkout_branch="${git_branch_name_tmp}"
    git fetch origin ${options}
    git checkout ${checkout_branch}
    #git pull

    __write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=git clone -b ${git_branch_name_tmp} --single-branch --depth 1 ${download_git_url_tmp} ${download_git_local_dirctoryname_tmp} >> $ACTIVE_LOG_FNAME"
    #git clone -b ${git_branch_name_tmp} --single-branch --depth 1 ${download_git_url_tmp} ${download_git_local_dirctoryname_tmp} >> $ACTIVE_LOG_FNAME 2>&1  #将代码下载到指定路径。命令为：git clone xxx.git “指定目录”

    #__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=cd ${checkout_work_path_tmp}"
    #cd ${checkout_work_path_tmp}

    #__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=git clean -fdx >> $ACTIVE_LOG_FNAME"
    #git clean -fdx >> $ACTIVE_LOG_FNAME 2>&1

    #__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=git checkout ${git_branch_name_tmp} || git checkout -b ${git_branch_name_tmp} >> $ACTIVE_LOG_FNAME"
    #git checkout ${git_branch_name_tmp} || git checkout -b ${git_branch_name_tmp} >> $ACTIVE_LOG_FNAME 2>&1

    #__write_log "$(basename $BASH_SOURCE), $LINENO" "git pull ${download_git_url} ${git_branch_name_tmp} >> $ACTIVE_LOG_FNAME"
    #git pull ${download_git_url} ${git_branch_name_tmp} >> $ACTIVE_LOG_FNAME 2>&1


}



###################################################################################
# 函数名称： __git_download_extra
# 功能描述： -- 下载服务代码patch仓
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __git_download_extra() {
    __write_log "$(basename $BASH_SOURCE), $LINENO" " "
    __write_log "$(basename $BASH_SOURCE), $LINENO" "enter function: __git_download_extra()"

    #通过python脚本的方法，下载patch仓
    __write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=python ${common_path}/git_download_func.py download_git_repo --url ${git_url_patch} --branch ${branch_extra_name} --path ${git_patch_path} --logfile ${ACTIVE_LOG_FNAME}"
    python ${common_path}/git_download_func.py download_git_repo --url ${git_url_patch} --branch ${branch_name_patch} --path ${git_patch_path} --logfile ${ACTIVE_LOG_FNAME}

    if [ $? -ne "0" ];then
        __write_log "$(basename $BASH_SOURCE), $LINENO" "Error: exec python ${common_path}/git_download_func.py download_git_repo --url ${git_url_patch} --branch ${branch_extra_name} failed!. exit (1)."
        exit 1
    fi

}



###################################################################################
# 函数名称： __central_repo_download
# 功能描述： -- 下载开源中心仓代码
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __central_repo_download() {
    __write_log "$(basename $BASH_SOURCE), $LINENO" "enter function: __central_repo_download()"

    #通过python脚本的方法，直接通过build.yaml下载开源中心仓的代码
    __write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=python ${common_path}/git_download_func.py wget_download_source --url ${central_repo_url} --path ${central_patch_path} --logfile ${ACTIVE_LOG_FNAME}"
    python ${common_path}/git_download_func.py wget_download_source --url ${central_repo_url} --path ${central_patch_path} --logfile ${ACTIVE_LOG_FNAME}

    if [ $? -ne "0" ];then
        __write_log "$(basename $BASH_SOURCE), $LINENO" "Error: exec python ${common_path}/git_download_func.py wget_download_source --url ${central_repo_url} --path ${central_patch_path} --logfile ${ACTIVE_LOG_FNAME} failed!. exit (1)."
        exit 1
    fi
}



get_is_patch_result=1

###################################################################################
# 函数名称： __get_is_patch
# 功能描述： 确定is_patch等于true OR false
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __get_is_patch() {
    __write_log "$(basename $BASH_SOURCE):$LINENO" "enter function: __get_is_patch()"
    get_is_patch_result=0
    __write_log "$(basename $BASH_SOURCE):$LINENO" "para: is_patch=true"
    __write_log "$(basename $BASH_SOURCE):$LINENO" "end function: __preprocess_patch()"
}



###################################################################################
# 函数名称： __preprocess_patch
# 功能描述： patch化构建：补丁预处理
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __preprocess_patch_pre() {
    __write_log "$(basename $BASH_SOURCE):$LINENO" "enter function: __preprocess_patch_pre()"
    #当xis_patch等于"true"时,进行patch化预处理
    __get_is_patch
    if [[ ${get_is_patch_result} == 0 ]]; then
        if [[ -d "${patch_build}" ]]; then
            __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=rm -rf ${patch_build}"
            rm -rf ${patch_build}
        fi
        __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=mkdir -p ${patch_build}"
        mkdir -p ${patch_build}

        #打patch的前置处理
        if [ -d $work_fst_solution_path/$service_name/patch_pre ]; then
            __write_log "$(basename $BASH_SOURCE), $LINENO" ". $work_fst_solution_path/$service_name/patch_pre/patch-pre.sh"
            chmod +x $work_fst_solution_path/$service_name/patch_pre/*.sh
            . $work_fst_solution_path/$service_name/patch_pre/patch-pre.sh
            if [ "$?" != "0" ];then
                __write_log "$(basename $BASH_SOURCE), $LINENO" "Error: . $work_fst_solution_path/$service_name/patch_pre/patch-pre.sh."
                exit 1
            fi
        fi

    else
        __write_log "$(basename $BASH_SOURCE):$LINENO" "is_patch is false"
    fi
    __write_log "$(basename $BASH_SOURCE):$LINENO" "end function: __preprocess_patch()"
}



###################################################################################
# 函数名称： __apply_patch
# 功能描述： 打patch补丁
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __apply_patch(){
    __write_log "$(basename $BASH_SOURCE):$LINENO" "enter function: __apply_patch()"
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=chmod -R 750 ${patch_build}"
    chmod -R 750 ${patch_build}
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=cd ${patch_build}"
    cd ${patch_build}
    cat ${patch_code}/config/patch.conf | while read line
    do
        __write_log "$(basename $BASH_SOURCE):$LINENO" "line=${line}"

        lineopensource=`echo $line | awk 'BEGIN {FS=" "}{print $2}'`
        if [[ $lineopensource = "opensource" ]]; then
            lineopensource="opensource_patch"
        elif [[ $lineopensource = "huawei" ]]; then
            lineopensource="huawei_patch"
        else
            __write_log "$(basename $BASH_SOURCE):$LINENO" "Waring:lineopensource is not opensource or huawei,please check"
        fi
        linepatchfile=`echo $line | awk 'BEGIN {FS=" "}{print $3}'`
        __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=cd ${patch_build}"
        cd ${patch_build}
        #patch构建，失败则退出构建
        __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=git apply ${patch_code}/$lineopensource/$linepatchfile"
        git apply ${patch_code}/$lineopensource/$linepatchfile
        if [ "$?" != "0" ]; then
            __write_log "ERROR" "$(basename $BASH_SOURCE):$LINENO" "Failed to git apply ${patch_code}/$lineopensource/$linepatchfile"
            return 1
        fi
    done
    __write_log "$(basename $BASH_SOURCE):$LINENO" "end function: __apply_patch()"
}



###################################################################################
# 函数名称： __process_service_patch
# 功能描述： 打patch入团队git代码
#           1. 复制代码到 [服务名_build] 目录下
#           2. 打入patch
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __process_service_patch() {
    __write_log "$(basename $BASH_SOURCE):$LINENO" "enter function: __process_service_patch()"
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=cp -r ${work_path}/${service_name}/. ${project_patch_path}/"
    cp -r ${work_path}/${service_name}/. ${project_patch_path}/

    #__write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=__apply_patch()"
    #__apply_patch

    __write_log "$(basename $BASH_SOURCE):$LINENO" "end function: __process_service_patch()"
}



###################################################################################
# 函数名称： __process_bep_files
# 功能描述： 打patch入团队git代码
#           1. 复制代码到 [服务名_build] 目录下
#           2. 打入patch
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
function __process_bep_files() {
    __write_log "$(basename $BASH_SOURCE):$LINENO" "enter function: __process_bep_files()"

    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=mkdir -p ${post_dir}"
    mkdir -p ${post_dir}
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=mkdir -p ${pre_dir}"
    mkdir -p ${pre_dir}

    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=cd ${patch_build}"
    cd ${patch_build}
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=zip -q -r ${post_dir}/${service_name}_patch_build.zip *"
    zip -q -r ${post_dir}/${service_name}_build.zip *

    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=cd ${project_patch_path}"
    cd ${project_patch_path}
    __write_log "$(basename $BASH_SOURCE):$LINENO" "exec command=zip -q -r ${pre_dir}/${service_name}_build.zip *"
    zip -q -r ${pre_dir}/${service_name}_build.zip *

    __write_log "$(basename $BASH_SOURCE):$LINENO" "end function: __process_bep_files()"
}



###################################################################################
# 函数名称： format_yaml
# 输入参数： 1、build.yaml所在路径
#            2、输出build_tmp.yaml路径
# 返回  值： 无
###################################################################################
function format_yaml() {
    __write_log "$(basename $BASH_SOURCE), $LINENO" " "
    __write_log "$(basename $BASH_SOURCE), $LINENO" "enter function: format_yaml()"
    local servicePath=$1
    local outputPath=$2

    arch=$(uname -m)
    #格式化yaml
    #__write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=cmd=python ${work_fst_build_path}/src/common/xml_parser.py -cmd get_construct_env_cmd -f ${work_fst_solution_retrack_path}/${CONSTRUCT_FILE} $arm_or_x86"
    #add_cmd=$(python ${work_fst_build_path}/src/common/xml_parser.py -cmd get_construct_env_cmd -f ${work_fst_solution_retrack_path}/${CONSTRUCT_FILE} $arm_or_x86)

    __write_log "$(basename $BASH_SOURCE), $LINENO" "exec command=python ${work_fst_build_path}/src/common/yaml_parser.py -cmd format -w $src_path_service -c $servicePath/build.yaml -d branch_name=$branchName"
    cmd="python ${work_fst_build_path}/src/common/yaml_parser.py -cmd format -w $src_path_service -c $servicePath/build.yaml -d branch_name=$branchName"
    eval ${cmd}
}



###################################################################################
# 函数名称： __configure_patch_branch
# 功能描述： 配置patch仓的分支
# 输入参数： 无
# 返回  值： 无
###################################################################################
function __configure_patch_branch() {
    __write_log "$(basename $BASH_SOURCE), $LINENO" " "
    __write_log "$(basename $BASH_SOURCE), $LINENO" "enter function: __configure_patch_branch()"

    if [[ "${service_name}" = "helm" ]]; then
      export branch_name_patch="personal/n30001436/patch"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch=personal/n30001436/patch"
    elif [[ "${service_name}" = "api" ]]; then
      export branch_name_patch="kubernetes/api-patch/opensource-1.19.0"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch=kubernetes/api-patch/opensource-1.19.0"
    elif [[ "${service_name}" = "apiserver" ]]; then
      export branch_name_patch="kubernetes/apiserver-patch/opensource-1.19.0"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch=kubernetes/apiserver-patch/opensource-1.19.0"
    elif [[ "${service_name}" = "apimachinery" ]]; then
      export branch_name_patch=" kubernetes/apimachinery-patch/opensource-1.19.0"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch= kubernetes/apimachinery-patch/opensource-1.19.0"
    elif [[ "${service_name}" = "client-go" ]]; then
      export branch_name_patch="kubernetes/client-go-patch/opensource-1.19.0"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch=kubernetes/client-go-patch/opensource-1.19.0"
    elif [[ "${service_name}" = "gophercloud" ]]; then
      export branch_name_patch="gophercloud-patch/github-v0.10.0-opensource"
      __write_log "$(basename $BASH_SOURCE), $LINENO" "branch_name_patch=gophercloud-patch/github-v0.10.0-opensource"
    else
      export branch_name_patch="${branchName}"
    fi

    __write_log "$(basename $BASH_SOURCE), $LINENO" "end function: __configure_patch_branch()"
}



echo "common_func.sh Be Call"
