<?

require 'acs.php';

header('Content-type: application/json');
print '{ "app": "'.get_app_token().'" }';
