<?

require 'acs.php';

/* https://developers.facebook.com/docs/facebook-login/login-flow-for-web-no-jssdk/ */

function get_user_code() {
    $dialog_url = 'https://www.facebook.com/dialog/oauth';
    $query_data = http_build_query(array(
        'client_id' => APP_ID,
        'redirect_uri' => REDIRECT_URL
        // token is passed as URL fragment and can't be accessed by php
        /* 'response_type' => 'token' */
    ));

    $url = $dialog_url.'?'.$query_data;

    header("Location: ".$url);
    die();
}

function exchange_code($code) {
    // exchange code -> token
    $query_data = array(
        'code' => $code,
        'redirect_uri' => REDIRECT_URL
    );
    $array = fb_graph_request($query_data);

    // inspect token
    $endpoint = '/debug_token';
    $query_data = array(
        'input_token' => $array['access_token'],
        'access_token' => get_app_token()
    );
    $json = fb_graph_request($query_data, $endpoint, false);
    $inspect = json_decode($json, true);
    if ($inspect['data']['app_id'] == APP_ID &&
        $inspect['data']['user_id'] == USER_ID) {
        return $array;
    }
    die("Invalid app id or user id.");
}

// redirect after login dialog
if (isset($_GET['code'])) {
    $code = $_GET['code'];
    $array = exchange_code($code);
    $token = $array['access_token'];
    $expires = $array['expires'];
    $days = $expires/60/60/24;
    header('Content-type: text/plain');
    print"$token\n";
    print "Save token to file! Expires in $days days.";
} else {
    get_user_code();
}
