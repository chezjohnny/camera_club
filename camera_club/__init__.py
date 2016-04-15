# -*- coding: utf-8 -*-
from flask import Flask,  render_template, request, flash, redirect, url_for,\
    current_app, redirect, abort
from flask.ext.assets import Environment, Bundle
from flaskext.markdown import Markdown

import sys
import os
#sys.setdefaultencoding('utf-8')
 

def create_app():
    app = Flask(__name__)
    app.secret_key = '09834jkfda8923'

    Markdown(app)
    assets = Environment(app) 
    css = Bundle (
        'scss/styles.scss',
        filters='scss, cleancss',
        depends=('scss/*.scss', ),
        output='gen/camera_club.%(version)s.css',
    )
    assets.register('css_all', css)

    js = Bundle (
        Bundle(
            'node_modules/almond/almond.js',
            filters='uglifyjs',
        ),
        Bundle(
            'js/base.js',
            filters='requirejs',
        ),
        filters='jsmin',
        output="gen/camera_club.%(version)s.js",)
    assets.register('js_all', js)


    @app.route('/')
    def index():
        md_file = os.path.join(current_app.static_folder, "contents", "index.md")
        content = file(md_file).read()
        return render_template("index.html", title="Welcome", content=content)

    @app.route('/news')
    def news():
        md_file = os.path.join(current_app.static_folder, "contents", "news.md")
        content = file(md_file).read()
        return render_template("index.html", content=content)

    @app.errorhandler(404)
    def page_not_found(e):
        return render_template('404.html', title=u"Page non trouvée", msg=u"Ce que vous cherchez n'est simplement pas ici."), 404
    return app
