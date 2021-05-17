<?php

namespace app\controllers;

use core\App;
use core\Message;
use core\Utils;

/**
 * HelloWorld built in Amelia - sample controller
 *
 * @author Przemysław Kudłacik
 */
class HelloCtrl {

    public function action_hello() {

        $variable = 123;
        $login = "admin";
        $pwd = "0000";

        try {
            $hashed_pwd = App::getDB()->get("user", "password", [
                "login" => $login
            ]);
        } catch (PDOException $ex) {
            getMessages()->addError('Wystąpił błąd podczas pobierania rekordów');
            if (getConf()->debug) {
                getMessages()->addError($ex->getMessage());
            }
        }
        
        if (password_verify($pwd, $hashed_pwd)) {
            echo 'Password is valid!';
        } else {
            echo 'Invalid password.';
        }

//        App::getMessages()->addMessage(new Message("Hello world message", Message::INFO));
//        Utils::addInfoMessage("Or even easier message :-)");

        App::getSmarty()->assign("value", $variable);
        App::getSmarty()->display("Hello.tpl");
    }

}
