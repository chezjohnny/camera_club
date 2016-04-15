#!/usr/bin/env python
# -*- coding: utf-8 -*-
""" Camera Club Flask Application."""
__author__ = "Johnny Mariethoz <chezjohnny@gmail.com>"
__version__ = "0.0.0"
__copyright__ = "Copyright (c) 2016, Johnny Mariethoz"
__license__ = "Internal Use Only"


from setuptools import setup, find_packages

setup(
    name='CameraClub',
    version='1.0',
    long_description=__doc__,
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=[
    'Flask>=0.10',
    #'Flask-WTF>=0.8.3',
    #'Flask-Mail>=0.9',
    'Flask-Assets>=0.8',
    'cssmin>=0.1.4',
    'jsmin>=0.1.4',
    'Flask-Markdown>=0.3'
    #"mutagen>=1.22"
    ]
)
