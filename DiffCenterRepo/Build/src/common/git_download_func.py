import os
import subprocess
from python_utils import logging_model
import argparse

logger = logging_model.Logger()


###################################################################################
# 函数名称： exec_shell_command
# 功能描述： 执行一条shell命令
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
def execute_shell_command(command_str):
    logger.debug("enter execute_shell_command()")
    logger.debug("begin to exec command=%s" % command_str)

    result = subprocess.run(command_str, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

    if result.returncode != 0:
        logger.debug("error: status=" + str(result.returncode) + ". exec command failed.")
    else:
        logger.debug("exec command succeed.\n")

    return result.returncode, result.stdout.decode()


###################################################################################
# 函数名称： delete_exist_dir
# 功能描述： 如果一个目录已经存在，删除它
# 输入参数：
# 输出参数：
# 返回  值： 无
###################################################################################
def delete_exist_dir(dir_path):
    if os.path.exists(dir_path):
        rm_path_command = 'rm -rf %s' % dir_path
        execute_shell_command(rm_path_command)


###################################################################################
# 函数名称： download_git_repo
# 功能描述： 下载一个git仓
# 输入参数： git_url, branch, save_path(代码仓保存路径)
# 输出参数：
# 返回  值： 整型：status。如果执行正确，返回0。执行错误，返回非0
###################################################################################
def download_git_repo(git_url, branch, save_path):
    # 如果save_path目录已经存在，则先删除
    delete_exist_dir(save_path)

    # 下载代码仓
    download_git_command = ' '.join(['git clone -b', branch, '--depth 1', git_url, save_path])
    execute_shell_command(download_git_command)


###################################################################################
# 函数名称： download_source
# 功能描述： 根据链接使用wget下载一个资源文件
# 输入参数： remote_url, save_path
# 输出参数：
# 返回  值： 整型：status。如果执行正确，返回0。执行错误，返回非0
###################################################################################
def wget_download_source(remote_url, save_path):
    # 如果save_path目录已经存在，则先删除
    delete_exist_dir(save_path)

    wget_command = ' '.join(['wget -P', save_path, remote_url])
    execute_shell_command(wget_command)


###################################################################################
# 函数名称： handle_download_git_repo_parser
# 功能描述： 处理download_git_repo参数
# 输入参数：
# 输出参数：
# 返回  值：
###################################################################################
def handle_download_git_repo_parser(args):
    git_url, branch, save_path, log_file = args.url, args.branch, args.path, args.logfile

    logging_model.set_logfile(logger, log_file)
    download_git_repo(git_url, branch, save_path)


###################################################################################
# 函数名称： handle_wget_download_source_parser
# 功能描述： 处理wget_download_source参数
# 输入参数：
# 输出参数：
# 返回  值：
###################################################################################
def handle_wget_download_source_parser(args):
    url, save_path, log_file = args.url, args.path, args.logfile

    logging_model.set_logfile(logger, log_file)
    wget_download_source(url, save_path)


###################################################################################
# 函数名称： main
# 功能描述： 主函数
# 输入参数：
# 输出参数：
# 返回  值： 整型：status。如果执行正确，返回0。执行错误，返回非0
###################################################################################
def main():
    parser = argparse.ArgumentParser()

    subparsers = parser.add_subparsers(help='commands')

    download_git_repo_parser = subparsers.add_parser(name='download_git_repo', help='download_git_repo')
    download_git_repo_parser.add_argument('--url', required=True, help='remote url')
    download_git_repo_parser.add_argument('--branch', required=True, help='branch')
    download_git_repo_parser.add_argument('--path', required=True, help="save path")
    download_git_repo_parser.add_argument('--logfile', required=True, help="log file path")
    download_git_repo_parser.set_defaults(func=handle_download_git_repo_parser)

    wget_download_source_parser = subparsers.add_parser(name='wget_download_source', help='wget_download_source')
    wget_download_source_parser.add_argument('--url', required=True, help='git url')
    wget_download_source_parser.add_argument('--path', required=True, help="save path")
    wget_download_source_parser.add_argument('--logfile', required=True, help="log file path")
    wget_download_source_parser.set_defaults(func=handle_wget_download_source_parser)

    args = parser.parse_args()
    # 执行函数功能
    args.func(args)


if __name__ == '__main__':
    main()
