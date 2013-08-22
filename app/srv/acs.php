<?php

/* ******* CONFIG ******* */

require 'secret.php';
/* Contains 2 lines:
 * define('APP_SECRET', 'theAppSecret');
 * define('USER_TOKEN', 'theUserToken');
 */

define('APP_ID', '157521754433538');
define('USER_ID', '100006390901187');

/* ***** END CONFIG ***** */

define('GRAPH_API_URL', 'https://graph.facebook.com');
define('REDIRECT_URL', 'http://'.$_SERVER['HTTP_HOST'].'/srv/login_user.php');

/* https://developers.facebook.com/docs/facebook-login/access-tokens/ */

function fb_graph_request($query_data, $endpoint='/oauth/access_token', $parse_array=true) {
    if ($endpoint == '/oauth/access_token') {
        $query_data['client_id'] = APP_ID;
        $query_data['client_secret'] = APP_SECRET;
    }
    $url = GRAPH_API_URL.$endpoint.'?'.http_build_query($query_data);

    $response = file_get_contents($url);

    if ($parse_array) {
        parse_str($response, $array);
        return $array;
    } else {
        return $response;
    }
}

function get_app_token() {
    $query_data = array(
        'grant_type' => 'client_credentials'
    );
    $array = fb_graph_request($query_data);
    return $array['access_token'];
}

header('access-control-allow-origin: *');
