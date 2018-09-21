#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os, logging, time

DEFAULT_LOGS_PATH = os.path.realpath(os.path.split(os.path.realpath(__file__))[0]+"/../logs")
#print(DEFAULT_LOGS_PATH)
#创建日志对象
def createLogger(name="", path=DEFAULT_LOGS_PATH, level=logging.WARNING):
    #
    logger = logging.getLogger(name)
    logger.setLevel(level)

    #print("1", id(logger))
    buildLogger(logger, path, level)

    return logger

#设置logger
def buildLogger(logger, path=DEFAULT_LOGS_PATH, level=logging.WARNING):

    #print("2", id(logger))

    #
    if not os.path.exists(path):
        os.makedirs(path)

    #
    logger.setLevel(level)

    # 文件名称
    filename = time.strftime("%Y%m%d.log", time.localtime())

    # 设置handler
    file_handler = logging.FileHandler(os.path.join(path, filename), encoding="utf-8")
    stream_handler = logging.StreamHandler()

    #print("日志级别", level)
    # 设置级别
    file_handler.setLevel(level)
    stream_handler.setLevel(level)

    # 设置format
    logging_format = logging.Formatter('[%(asctime)s %(name)s] %(levelname)s: %(message)s (%(filename)s at line %(lineno)s)')
    file_handler.setFormatter(logging_format)
    stream_handler.setFormatter(logging_format)

    logger.addHandler(file_handler)
    logger.addHandler(stream_handler)