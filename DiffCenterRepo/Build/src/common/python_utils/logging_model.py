import logging
import os
import time
import sys

formatter = logging.Formatter('[%(asctime)s][%(filename)s, %(lineno)s] %(message)s', datefmt='%m-%d %H:%M:%S')


class SingletonType(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super(SingletonType, cls).__call__(*args, **kwargs)
        return cls._instances[cls]


class Logger(metaclass=SingletonType):
    def __new__(cls, log_file=None, file_output=True, standard_output=True):
        # 日志文件的路径
        if log_file is None:
            # 文件的当前目录
            current_path = os.path.dirname(os.path.realpath(__file__))
            current_time = time.strftime("%Y-%m-%d-%H%M%S", time.localtime())
            log_file = os.path.join(current_path, 'log_output', f'{current_time}.txt')
            os.makedirs(os.path.dirname(log_file), exist_ok=True)

        cls.logger = logging.getLogger(__name__)
        standard_out = logging.StreamHandler(sys.stdout)
        standard_out.setFormatter(formatter)
        cls.logger.addHandler(standard_out)    # 添加标准输出
        return cls.logger


def set_logfile(logger, logfile):
    # 日志文件输出
    file_out = logging.FileHandler(logfile, encoding='utf-8')
    file_out.setFormatter(formatter)
    logger.addHandler(file_out)    # 添加文件输出
    logger.setLevel(logging.DEBUG)
