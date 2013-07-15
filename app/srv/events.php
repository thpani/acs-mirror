<?

require 'acs.php';

header('Content-type: application/json');
$query_str = http_build_query(array('access_token' => USER_TOKEN));
print file_get_contents('https://graph.facebook.com/552255311482154/events?'.$query_str);
