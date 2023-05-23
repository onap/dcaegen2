project = "onap"
release = "master"
version = "master"
branch = 'latest'
master_doc = 'index'

linkcheck_ignore = [
    r'http://localhost:\d+/',
    r'http:/',
    r'https://localhost:\d+/',
    r'https:/',
    r'jdbc:'
]

exclude_patterns = [
    r'.tox/**.rst'
]

extensions = [
    'sphinx.ext.intersphinx',
    'sphinx.ext.graphviz',
#    'sphinx.ext.autosectionlabel',
    'sphinxcontrib.blockdiag',
    'sphinxcontrib.seqdiag',
    'sphinxcontrib.swaggerdoc',
    'sphinxcontrib.plantuml'
]

pygments_style = "sphinx"
html_theme = "sphinx_rtd_theme"
html_theme_options = {
  "style_nav_header_background": "white",
  "sticky_navigation": "False" }
html_logo = "_static/logo_onap_2017.png"
html_favicon = "_static/favicon.ico"
html_static_path = ["_static"]
html_show_sphinx = False

intersphinx_mapping = {}

html_last_updated_fmt = '%d-%b-%y %H:%M'

def setup(app):
    app.add_css_file("css/ribbon.css")



