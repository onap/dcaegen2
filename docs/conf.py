project = "onap"
release = "london"
version = "london"
branch = 'london'
master_doc = 'index'

author = "Open Network Automation Platform"
# yamllint disable-line rule:line-length
copyright = "ONAP. Licensed under Creative Commons Attribution 4.0 International License"
exclude_patterns = [
    '.tox'
]

linkcheck_ignore = [
  r'http://localhost:\d+/'
]

extensions = [
    'sphinx.ext.intersphinx',
    'sphinx.ext.graphviz',
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



